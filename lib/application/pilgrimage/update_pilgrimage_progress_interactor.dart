import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_result.codegen.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_usecase.dart';
import 'package:virtualpilgrimage/application/user/health/health_repository.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/virtual_position_calculator.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

// お遍路の進捗を更新するUseCaseの実装
class UpdatePilgrimageProgressInteractor extends UpdatePilgrimageProgressUsecase {
  UpdatePilgrimageProgressInteractor(
    this._templeRepository,
    this._healthRepository,
    this._userRepository,
    this._virtualPositionCalculator,
    this._logger,
  );

  final TempleRepository _templeRepository;
  final HealthRepository _healthRepository;
  final UserRepository _userRepository;
  final VirtualPositionCalculator _virtualPositionCalculator;
  final Logger _logger;

  // 札所の数
  static const maxTempleNumber = 88;

  /// お遍路の進捗状況を更新し、ユーザの仮想的な歩行経路と現在地点を返す
  ///
  /// [userId] 更新対象のユーザID
  @override
  Future<UpdatePilgrimageProgressResult> execute(String userId) async {
    final now = CustomizableDateTime.current;
    final user = await _userRepository.get(userId);
    if (user == null) {
      return const UpdatePilgrimageProgressResult(
        status: UpdatePilgrimageProgressResultStatus.failWithGetUser,
        reachedPilgrimageIdList: [],
      );
    }

    // 到達した札所のID一覧
    final List<int> reachedPilgrimageIdList = [];
    try {
      final updatedProgressUser = await _calcPilgrimageProgress(user, now, reachedPilgrimageIdList);

      // 現在経路の緯度経度を取得
      final nextTargetTempleInfo =
          await _templeRepository.getTempleInfo(updatedProgressUser.pilgrimage.nowPilgrimageId);
      final latlngs = nextTargetTempleInfo.decodeGeoPoint();
      final virtualPosition = _virtualPositionCalculator.execute(
        latlngs,
        updatedProgressUser.pilgrimage.movingDistance,
      );
      // 念の為、レスポンスに使う全ての情報が出揃ってからユーザ情報を更新
      await _userRepository.update(updatedProgressUser);

      return UpdatePilgrimageProgressResult(
        status: UpdatePilgrimageProgressResultStatus.success,
        reachedPilgrimageIdList: reachedPilgrimageIdList,
        updatedUser: updatedProgressUser,
        virtualPolylineLatLngs: latlngs,
        virtualPosition: virtualPosition,
      );
    } on Exception catch (e) {
      _logger.e(e);
      return UpdatePilgrimageProgressResult(
        status: UpdatePilgrimageProgressResultStatus.fail,
        reachedPilgrimageIdList: [],
        error: e,
      );
    }
  }

  /// お遍路の進捗状況を更新
  ///
  /// [user] ユーザ情報
  /// [now] 進捗状況を更新する時間
  /// [reachedPilgrimageIdList] 到達した札所の番号を格納するリスト
  Future<VirtualPilgrimageUser> _calcPilgrimageProgress(
    VirtualPilgrimageUser user,
    DateTime now,
    List<int> reachedPilgrimageIdList,
  ) async {
    final lastProgressUpdatedAt = user.pilgrimage.updatedAt;
    int lap = user.pilgrimage.lap;
    int nextPilgrimageId = user.pilgrimage.nowPilgrimageId;

    _logger.d(
      'update pilgrimage progress start '
      '[nextPilgrimageId][$nextPilgrimageId]'
      '[from][$lastProgressUpdatedAt]'
      '[to][$now]',
    );

    /// 1. 進捗を更新するために必要な情報を取得
    // 最大で2回外部通信する必要があるため、並列でまとめて実行
    // 現在、ユーザが目指している札所の情報と最終更新時間からのユーザのヘルスケア情報を取得
    late TempleInfo nowTempleInfo;
    late final HealthByPeriod healthFromLastUpdatedAt;
    {
      await Future.wait(<Future<void>>[
        _templeRepository.getTempleInfo(nextPilgrimageId).then((value) => nowTempleInfo = value),
        _healthRepository
            .getHealthByPeriod(from: lastProgressUpdatedAt, to: now)
            .then((value) => healthFromLastUpdatedAt = value),
      ]);
      _logger.d(
        'got info for updating pilgrimage progress '
        '[health][$healthFromLastUpdatedAt]'
        '[nowTempleInfo][$nowTempleInfo]',
      );
    }

    /// 2. 移動距離 > 次の札所までの距離 の間、で移動距離を減らしながら次に目指すべき札所を導出する
    // 次の札所に向かうまでの移動距離を格納する変数
    // お遍路の進捗の更新のために利用
    int movingDistance = user.pilgrimage.movingDistance + healthFromLastUpdatedAt.distance;
    {
      _logger.d(
        'calc pilgrimage progress '
        '[movingDistance][$movingDistance]'
        '[templeDistance][${nowTempleInfo.distance}]',
      );
      while (movingDistance >= nowTempleInfo.distance) {
        // 引数で与えた到達した札所をもらうid
        reachedPilgrimageIdList.add(_nextPilgrimageNumber(nowTempleInfo.id));
        // 札所までの距離を移動距離から引いて、札所を更新
        movingDistance -= nowTempleInfo.distance;
        nextPilgrimageId = _nextPilgrimageNumber(nextPilgrimageId);
        // 次の札所が1番札所の時、1番札所からお遍路を再開する事になるため、以下の処理を行う
        // - lap を1増やす
        // - 1番札所から再スタートするため、次の現在地点を1番札所に切り替える
        if (nextPilgrimageId == 88) {
          lap++;
          nextPilgrimageId = _nextPilgrimageNumber(nextPilgrimageId);
        }
        // NOTE: while で外部通信していて時間がかかるように見えるが、実際はキャッシュしたお寺の情報を問い合わせに行っているだけ
        nowTempleInfo = await _templeRepository.getTempleInfo(nextPilgrimageId);
        _logger.d(
          'calc pilgrimage progress '
          '[movingDistance][$movingDistance]'
          '[templeDistance][${nowTempleInfo.distance}]',
        );
      }
    }

    /// 3. 導出した進捗状況でユーザ情報を更新
    return user.updatePilgrimageProgress(nextPilgrimageId, lap, movingDistance, now);
  }

  /// 次の札所の番号を返す
  /// 88箇所目に到達していたら 1 を返す
  /// [pilgrimageId] 現在の札所の番号
  int _nextPilgrimageNumber(int pilgrimageId) {
    if (pilgrimageId < maxTempleNumber) {
      return pilgrimageId + 1;
    }
    return 1;
  }
}

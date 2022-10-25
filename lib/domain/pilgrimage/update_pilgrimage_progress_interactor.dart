import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:logger/logger.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maps;
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_result.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_usecase.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_repository.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

// お遍路の進捗を更新するUseCaseの実装
class UpdatePilgrimageProgressInteractor extends UpdatePilgrimageProgressUsecase {
  UpdatePilgrimageProgressInteractor(
    this._templeRepository,
    this._healthRepository,
    this._userRepository,
    this._logger,
  );

  final TempleRepository _templeRepository;
  final HealthRepository _healthRepository;
  final UserRepository _userRepository;
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
      final latlngs = await _getPilgrimagePolylines(updatedProgressUser);
      final virtualPosition = _calcVirtualPosition(
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

    // ロジックに利用する変数群
    late TempleInfo nowTempleInfo;
    late HealthByPeriod healthFromLastUpdatedAt;
    // 次の札所に向かうまでの移動距離を格納する変数
    // お遍路の進捗の更新のために利用
    int movingDistance;

    _logger.d(
      'update pilgrimage progress start '
      '[nextPilgrimageId][$nextPilgrimageId]'
      '[from][$lastProgressUpdatedAt]'
      '[to][$now]',
    );

    /// 1. 進捗を更新するために必要な情報を取得
    // 最大で2回外部通信する必要があるため、並列でまとめて実行
    // 現在、ユーザが目指している札所の情報と最終更新時間からのユーザのヘルスケア情報を取得
    await Future.wait(<Future<void>>[
      _templeRepository.getTempleInfo(nextPilgrimageId).then((value) => nowTempleInfo = value),
      _healthRepository
          .getHealthByPeriod(from: lastProgressUpdatedAt, to: now)
          .then((value) => healthFromLastUpdatedAt = value),
    ]);
    _logger.d(
      'got info for updating pilgrimage progress '
      '[nowTempleInfo][$nowTempleInfo]'
      '[health][$healthFromLastUpdatedAt]',
    );

    /// 2. 移動距離 > 次の札所までの距離 の間、で移動距離を減らしながら次に目指すべき札所を導出する
    movingDistance = user.pilgrimage.movingDistance + healthFromLastUpdatedAt.distance;
    _logger.d(
      'calc pilgrimage progress '
      '[movingDistance][$movingDistance]'
      '[templeDistance][${nowTempleInfo.distance}]',
    );
    while (movingDistance >= nowTempleInfo.distance) {
      // 引数で与えた到達した札所をもらうid
      reachedPilgrimageIdList.add(nowTempleInfo.id);
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

    /// 3. 導出した進捗状況でユーザ情報を更新
    final updatedPilgrimage = user.pilgrimage.copyWith(
      nowPilgrimageId: nextPilgrimageId,
      lap: lap,
      movingDistance: movingDistance,
      updatedAt: now,
    );
    return user.copyWith(pilgrimage: updatedPilgrimage, updatedAt: now);
  }

  /// map 上で2点間の経路を可視化するための情報を取得するメソッド
  Future<List<LatLng>> _getPilgrimagePolylines(VirtualPilgrimageUser user) async {
    final templeInfo = await _templeRepository.getTempleInfo(user.pilgrimage.nowPilgrimageId);
    // エンコードされた経路文字列を経路の緯度・経度のリストにして返す
    return decodePolyline(templeInfo.encodedPoints)
        .map((ep) => LatLng(ep.first.toDouble(), ep.last.toDouble()))
        .toList();
  }

  /// 経路情報（リスト）から仮想的なMap上の現在地を算出する
  LatLng _calcVirtualPosition(List<LatLng> latlngs, num meter) {
    num distance = meter;
    for (int i = 0; i < latlngs.length - 1; i++) {
      final from = maps.LatLng(latlngs[i].latitude, latlngs[i].longitude);
      final to = maps.LatLng(latlngs[i + 1].latitude, latlngs[i + 1].longitude);
      final num d = maps.SphericalUtil.computeDistanceBetween(from, to);
      if (distance < d) {
        // fromからtoの間にいる場合は割合で表示する
        final latlng = maps.SphericalUtil.interpolate(from, to, distance / d);
        return LatLng(latlng.latitude, latlng.longitude);
      } else {
        // fromからtoの距離をdistanceが超える場合は次の区間で計算する
        distance = distance - d;
      }
    }

    // 経路リストを超える場合は次のお寺にほぼ到着している
    return latlngs.last;
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

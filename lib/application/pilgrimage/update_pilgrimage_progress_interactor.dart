import 'dart:async';
import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:virtualpilgrimage/application/health/daily_health_log_repository.dart';
import 'package:virtualpilgrimage/application/health/health_gateway.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_result.codegen.dart';
import 'package:virtualpilgrimage/application/pilgrimage/update_pilgrimage_progress_usecase.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/health/daily_health_log.codegen.dart';
import 'package:virtualpilgrimage/domain/health/health_aggregation_result.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/virtual_position_calculator.dart';
import 'package:virtualpilgrimage/domain/user/health/health_by_period.codegen.dart';
import 'package:virtualpilgrimage/domain/user/health/health_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

// お遍路の進捗を更新するUseCaseの実装
class UpdatePilgrimageProgressInteractor extends UpdatePilgrimageProgressUsecase {
  UpdatePilgrimageProgressInteractor(
    this._templeRepository,
    this._healthRepository,
    this._userRepository,
    this._dailyHealthLogRepository,
    this._virtualPositionCalculator,
    this._logger,
    this._crashlytics,
  );

  final TempleRepository _templeRepository;
  final HealthGateway _healthRepository;
  final UserRepository _userRepository;
  final DailyHealthLogRepository _dailyHealthLogRepository;
  final VirtualPositionCalculator _virtualPositionCalculator;
  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;

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
      final updatedProgressUser =
          await _calcPilgrimageProgressAndUpdateHealth(user, now, reachedPilgrimageIdList);

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
      _logger.i('updated user: $updatedProgressUser');

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
  Future<VirtualPilgrimageUser> _calcPilgrimageProgressAndUpdateHealth(
    VirtualPilgrimageUser user,
    DateTime now,
    List<int> reachedPilgrimageIdList,
  ) async {
    final lastProgressUpdatedAt = user.updatedAt;
    final int nextPilgrimageId = user.pilgrimage.nowPilgrimageId;

    _logger.d(
      'update pilgrimage progress start '
      '[nextPilgrimageId][$nextPilgrimageId]'
      '[from][$lastProgressUpdatedAt]'
      '[to][$now]',
    );

    /// 1. 進捗を更新するために必要な情報を取得
    // 最大で2回外部通信する必要があるため、並列でまとめて実行
    // 現在、ユーザが目指している札所の情報と最終更新時間からのユーザのヘルスケア情報を取得
    late TempleInfo nowTargetTemple;
    late final HealthAggregationResult healthAggregationResult;
    late final HealthByPeriod? todayHealth;
    {
      final today = tz.TZDateTime(tz.getLocation('Asia/Tokyo'), now.year, now.month, now.day);
      await Future.wait(<Future<void>>[
        _templeRepository.getTempleInfo(nextPilgrimageId).then((value) => nowTargetTemple = value),
        // 今日のヘルスケア情報を取得
        _healthRepository
            .aggregateHealthByPeriod(
              from: today,
              to: now,
            )
            .then((value) => todayHealth = value.eachDay[today]),
        // 前回更新した時刻の開始地点 ~ 現在時刻で集計
        _healthRepository
            .aggregateHealthByPeriod(
              from: lastProgressUpdatedAt,
              to: now,
            )
            .then((value) => healthAggregationResult = value),
      ]);
      _logger.d(
        'got info for updating pilgrimage progress '
        '[health][$healthAggregationResult]'
        '[nowTempleInfo][$nowTargetTemple]',
      );
      // バリデーションで更新する必要がない場合は早期終了
      if (!healthAggregationResult.total.validate()) {
        final msg =
            'no health data [userId][${user.id}][from][$lastProgressUpdatedAt][to][$now][result][$healthAggregationResult]';
        _logger.i(msg);
        unawaited(_crashlytics.log(msg));
        return user;
      }
    }

    /// 2. 最後に保存した日毎のヘルスケア情報を取得
    /// 3 で上書きされるので、この時点で保持しておく
    final lastHealth = await _dailyHealthLogRepository.find(user.id, lastProgressUpdatedAt);

    /// 3. 非同期でユーザのヘルスケア情報を更新
    final updatedUser = await _updateUserHealth(
      user: user,
      healthAggregationResult: healthAggregationResult,
      todayHealth: todayHealth,
      now: now,
    );

    /// 4. 移動距離 > 次の札所までの距離 の間、で移動距離を減らしながら次に目指すべき札所を導出する
    return _updateUserPilgrimageProgress(
      user: updatedUser,
      totalDistance: healthAggregationResult.total.distance,
      nowTargetTemple: nowTargetTemple,
      reachedPilgrimageIdList: reachedPilgrimageIdList,
      lastHealth: lastHealth,
      now: now,
    );
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

  /// ヘルスケア情報を更新する
  /// [user] ユーザ情報
  /// [healthAggregationResult] 集計したヘルスケア情報
  /// [now] 現在時刻
  Future<VirtualPilgrimageUser> _updateUserHealth({
    required VirtualPilgrimageUser user,
    required HealthAggregationResult healthAggregationResult,
    required HealthByPeriod? todayHealth,
    required DateTime now,
  }) async {
    var updatedUser = user;
    // 取得できた日毎のヘルスケア情報を更新
    _logger.d('aggregation health result: $healthAggregationResult');
    for (final e in healthAggregationResult.eachDay.entries) {
      final key = e.key;
      final value = e.value;
      final isToday = key.year == now.year && key.month == now.month && key.day == now.day;

      // 日毎のヘルスケア情報を書き込む
      // 仮に情報が存在する場合も上書きする
      final target = DailyHealthLog.createFromHealthByPeriod(
        userId: user.id,
        day: tz.TZDateTime(tz.getLocation('Asia/Tokyo'), key.year, key.month, key.day),
        healthByPeriod: isToday ? todayHealth ?? value : value,
      );
      _logger.d('save health [target][$target][date][$key]');
      unawaited(
        _dailyHealthLogRepository.update(target).onError(_crashlytics.recordError),
      );
      if (isToday) {
        final userHealth = user.health;
        // 今日の日付なら、health のなかに情報を入れておく
        final HealthInfo newHealthByPeriod = userHealth != null
            ? userHealth.copyWith(
                today: target.toHealthByPeriod(),
                updatedAt: now,
              )
            : HealthInfo(
                today: target.toHealthByPeriod(),
                yesterday: HealthByPeriod.getDefault(),
                week: HealthByPeriod.getDefault(),
                month: HealthByPeriod.getDefault(),
                updatedAt: now,
                totalSteps: target.steps,
                totalDistance: target.distance,
              );
        updatedUser = user.copyWith(health: newHealthByPeriod);
      }
    }

    return updatedUser;
  }

  /// お遍路の進捗を更新する
  /// [user] ユーザ情報
  /// [totalDistance] 集計した合計の移動距離
  /// [nowTargetTemple] 現在目標にしている札所の情報
  /// [reachedPilgrimageIdList] 到達した札所の番号一覧
  /// [lastHealth] 最後に保存を実行した日の日毎のヘルスケア情報
  /// [now] 現在時刻
  Future<VirtualPilgrimageUser> _updateUserPilgrimageProgress({
    required VirtualPilgrimageUser user,
    required int totalDistance,
    required TempleInfo nowTargetTemple,
    required List<int> reachedPilgrimageIdList,
    required DailyHealthLog? lastHealth,
    required DateTime now,
  }) async {
    int lap = user.pilgrimage.lap;
    int nextPilgrimageId = user.pilgrimage.nowPilgrimageId;
    // 次の札所に向かうまでの移動距離を格納する変数
    // お遍路の進捗の更新のために利用
    /// 現在までに移動した距離 + 集計によって得られた合計移動距離 - 最後に実行した日の移動距離
    /// 集計は最後に実行した日の 00:00 地点から現在時刻までで距離を取得する
    /// 最後に実行した時刻の距離を引くことで、「現在までに移動した距離 + 最後に実行した時刻 ~ 現在時刻までの移動距離」という計算になる
    int movingDistance = user.pilgrimage.movingDistance +
        totalDistance -
        (lastHealth != null ? lastHealth.distance : 0);
    movingDistance = max(movingDistance, 0);
    {
      _logger.d(
        'calc pilgrimage progress '
        '[movingDistance][$movingDistance]'
        '[templeDistance][${nowTargetTemple.distance}]',
      );
      while (movingDistance >= nowTargetTemple.distance) {
        // 引数で与えた到達した札所をもらうid
        reachedPilgrimageIdList.add(_nextPilgrimageNumber(nowTargetTemple.id));
        // 札所までの距離を移動距離から引いて、札所を更新
        movingDistance -= nowTargetTemple.distance;
        nextPilgrimageId = _nextPilgrimageNumber(nextPilgrimageId);
        // 次の札所が1番札所の時、1番札所からお遍路を再開する事になるため、以下の処理を行う
        // - lap を1増やす
        // - 1番札所から再スタートするため、次の現在地点を1番札所に切り替える
        if (nextPilgrimageId == 88) {
          lap++;
          nextPilgrimageId = _nextPilgrimageNumber(nextPilgrimageId);
        }
        nowTargetTemple = await _templeRepository.getTempleInfo(nextPilgrimageId);
        _logger.d(
          'calc pilgrimage progress '
          '[movingDistance][$movingDistance]'
          '[templeDistance][${nowTargetTemple.distance}]',
        );
      }
    }

    /// 4. 導出した進捗状況でユーザ情報を更新
    return user.updatePilgrimageProgress(nextPilgrimageId, lap, movingDistance, now);
  }
}

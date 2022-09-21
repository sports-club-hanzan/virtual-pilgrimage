import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/user/health/update_health_result.dart';
import 'package:virtualpilgrimage/domain/user/health/update_health_usecase.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';

import 'home_state.codegen.dart';

final homeProvider = StateNotifierProvider.autoDispose<HomePresenter, HomeState>(
  HomePresenter.new,
);

class HomePresenter extends StateNotifier<HomeState> {
  HomePresenter(this._ref)
      : super(
          const HomeState(),
        ) {
    _updateHealthUsecase = _ref.read(updateHealthUsecaseProvider);
    _analytics = _ref.read(analyticsProvider);
    _crashlytics = _ref.read(firebaseCrashlyticsProvider);
    initialize();
  }

  final Ref _ref;
  late final UpdateHealthUsecase _updateHealthUsecase;
  late final Analytics _analytics;
  late final FirebaseCrashlytics _crashlytics;

  /// 初期化処理
  /// 初期化時にユーザのヘルスケア情報を読み取ってDBに書き込む
  Future<void> initialize() async {
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.initializeHomePageAndGetHealth));

    final user = _ref.read(userStateProvider);
    // ログインしていない状態で Home Page に遷移してきても
    // 情報を描画できずどうしようもないので crash させる
    if (user == null) {
      const reason = 'user must be login in home page';
      await _crashlytics.recordError(ArgumentError(reason), null, reason: reason);
      _crashlytics.crash();
      return;
    }

    // ヘルスケア情報取得の権限が付与されていない場合、許可を得るダイアログを開く
    // TODO(s14t284): ヘルスケア情報を取得するダイアログで許可を押す旨をUIに表示した方が良いか検討
    if ((await Permission.activityRecognition.request()).isDenied) {
      await _crashlytics.recordError(
        'now allowed to get health information [userId][${user.id}]',
        null,
      );
      await openAppSettings();
    }

    final result = await _updateHealthUsecase.execute(user);
    if (result.status != UpdateHealthStatus.success) {
      await _crashlytics.recordError(
        result.error,
        null,
        reason: 'failed to record health information [status][${result.status}]',
      );
    }
  }
}

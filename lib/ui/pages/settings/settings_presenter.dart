import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/application/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/application/user/delete/delete_user_result.codegen.dart';
import 'package:virtualpilgrimage/application/user/delete/delete_user_usecase.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/pages/settings/settings_state.codegen.dart';

import 'components/delete_user_dialog.dart';

final appVersionProvider = FutureProvider<String>((ref) async {
  final fromPlatform = await PackageInfo.fromPlatform();
  return fromPlatform.version;
});

final settingsProvider = StateNotifierProvider.autoDispose<SettingsPresenter, SettingsState>(
  SettingsPresenter.new,
);

class SettingsPresenter extends StateNotifier<SettingsState> {
  SettingsPresenter(this._ref) : super(const SettingsState()) {
    _analytics = _ref.read(analyticsProvider);
    _crashlytics = _ref.read(firebaseCrashlyticsProvider);
    _router = _ref.read(routerProvider);
  }

  final Ref _ref;
  late final Analytics _analytics;
  late final FirebaseCrashlytics _crashlytics;
  late final GoRouter _router;

  /// 問い合わせのためのメーラーを開く
  Future<void> openMailerForInquiry() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    const address = 'pilgrimage.virtual@gmail.com';
    final Uri uri = Uri(
      scheme: 'mailto',
      path: address,
      query: encodeQueryParameters(<String, String>{
        'subject': '巡礼ウォークについての問い合わせ',
      }),
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // エラー処理
    }
  }

  /// ユーザ情報編集ページに遷移
  Future<void> moveEditUserInfoPage() async {
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.moveEditPage));
    _ref.read(routerProvider).push(RouterPath.edit);
  }

  /// ログアウト処理を行う
  Future<void> logout() async {
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.logout));
    await _ref.read(signInUsecaseProvider).logout();
    _ref.read(loginStateProvider.notifier).state = null;
    _ref.read(routerProvider).go(RouterPath.signIn);
  }

  /// ユーザ情報削除を行う
  Future<void> deleteUserInfo() async {
    final user = _ref.read(userStateProvider);
    // バリデーションしているものの、ここには到達しないはず
    if (user == null) {
      unawaited(_crashlytics.log('delete user error when user not login'));
      return;
    }
    final result = await _ref.read(deleteUserUsecaseProvider).execute(user);
    if (result.status != DeleteUserStatus.success) {
      return;
    }
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.successDeleteUser));
    unawaited(_crashlytics.log('success delete user [id][${user.id}]'));
    await _ref.read(signInUsecaseProvider).logout();
    _ref.read(loginStateProvider.notifier).state = null;
    _router.go(RouterPath.signIn);
  }

  /// ユーザを削除するダイアログを表示する
  Future<void> openDeleteUserDialog(BuildContext context) async {
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.openDeleteUserDialog));
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) => const DeleteUserDialog(),
    );
  }

  /// ユーザを削除するダイアログを閉じる
  Future<void> closeDeleteUserDialog(BuildContext context) async {
    Navigator.of(context).pop();
  }
}

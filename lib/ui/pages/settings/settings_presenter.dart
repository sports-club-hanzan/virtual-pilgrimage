import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info/package_info.dart';
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
  SettingsPresenter(this._ref) : super(const SettingsState());

  final Ref _ref;

  /// ログアウト処理を行う
  Future<void> logout() async {
    await _ref.read(analyticsProvider).logEvent(eventName: AnalyticsEvent.logout);
    await _ref.read(signInUsecaseProvider).logout();
    _ref.read(loginStateProvider.notifier).state = null;
    _ref.read(routerProvider).go(RouterPath.signIn);
  }

  /// ユーザ情報削除を行う
  Future<void> deleteUserInfo() async {
    final user = _ref.read(userStateProvider);
    // バリデーションしているものの、ここには到達しないはず
    if (user == null) {
      unawaited(_ref.read(firebaseCrashlyticsProvider).log('delete user error when user not logined'));
      return;
    }
    final result = await _ref.read(deleteUserUsecaseProvider).execute(user);
    if (result.status != DeleteUserStatus.success) {
      return;
    }
    await _ref.read(analyticsProvider).logEvent(eventName: AnalyticsEvent.successDeleteUser);
    await _ref.read(firebaseCrashlyticsProvider).log('success delete user [id][${user.id}]');
    await _ref.read(signInUsecaseProvider).logout();
    _ref.read(loginStateProvider.notifier).state = null;
    _ref.read(routerProvider).go(RouterPath.signIn);
  }

  /// ユーザを削除するダイアログを表示する
  Future<void> openDeleteUserDialog(BuildContext context) async {
    await _ref.read(analyticsProvider).logEvent(eventName: AnalyticsEvent.openDeleteUserDialog);
    await showDialog<void>(context: context, builder: (BuildContext context) => const DeleteUserDialog());
  }

  /// ユーザを削除するダイアログを閉じる
  Future<void> closeDeleteUserDialog(BuildContext context) async {
    Navigator.of(context).pop();
  }
}

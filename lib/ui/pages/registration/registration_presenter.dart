import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/application/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/application/user/registration/registration_result.dart';
import 'package:virtualpilgrimage/application/user/registration/user_registration_usecase.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/model/form_model.codegen.dart';
import 'package:virtualpilgrimage/ui/model/radio_button_model.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_state.codegen.dart';

final registrationPresenterProvider =
    StateNotifierProvider.autoDispose<RegistrationPresenter, RegistrationState>(
  (ref) => RegistrationPresenter(ref, ref.watch(userStateProvider)),
);

class RegistrationPresenter extends StateNotifier<RegistrationState> {
  RegistrationPresenter(this._ref, VirtualPilgrimageUser? user)
      : super(
          RegistrationState(
            nickname: FormModel.of(nicknameValidator, user?.nickname ?? ''),
            birthday: FormModel.of(
              birthdayValidator,
              user != null ? DateFormat('yyyyMMdd').format(user.birthDay) : '',
            ),
            gender: RadioButtonModel.of<Gender>(
              ['未設定', '男性', '女性'],
              Gender.values,
              selectedValue: user?.gender,
            ),
          ),
        ) {
    _usecase = _ref.read(userRegistrationUsecaseProvider);
    _analytics = _ref.read(analyticsProvider);
    _crashlytics = _ref.read(firebaseCrashlyticsProvider);
    _userStateNotifier = _ref.read(userStateProvider.notifier);
    _loginStateNotifier = _ref.read(loginStateProvider.notifier);
    isRegistered = _ref.read(userStateProvider)?.userStatus == UserStatus.created;
  }

  final Ref _ref;
  late final UserRegistrationUsecase _usecase;
  late final Analytics _analytics;
  late final FirebaseCrashlytics _crashlytics;
  late final StateController<VirtualPilgrimageUser?> _userStateNotifier;
  late final StateController<UserStatus?> _loginStateNotifier;
  final dateFormatter = DateFormat();

  // 作成済みの状態から遷移してきたかどうか
  late final bool isRegistered;

  void onChangedNickname(FormModel nickname) {
    state = state.onChangeNickname(nickname);
  }

  void onChangedBirthday(FormModel birthday) {
    state = state.onChangeBirthday(birthday);
  }

  void onChangedGender(Gender? gender) {
    state = state.onTapGenderButton(gender!);
  }

  Future<void> onPressedRegistration() async {
    final defaultParams = {
      'nickname': state.nickname.text,
      'gender': state.gender.selectedValue.name,
      'birthday': state.birthday.text,
    };
    await _analytics.logEvent(
      eventName: AnalyticsEvent.pressedRegistration,
      parameters: defaultParams,
    );
    state = state.onSubmit();
    // バリデーションエラーにかかっている場合はリクエストを送らない
    if (!state.nickname.isValid || !state.birthday.isValid) {
      unawaited(
        _analytics.logEvent(
          eventName: AnalyticsEvent.registrationFailed,
          parameters: {
            ...defaultParams,
            'nicknameValidationError': state.nickname.displayError ?? '',
            'birthdayValidationError': state.birthday.displayError ?? '',
          },
        ),
      );
      return;
    }

    late DateTime birthday;
    try {
      birthday = DateTime.parse(state.birthday.text);
    } on FormatException catch (e) {
      state = state.setExternalErrors(birthdayError: '生年月日の形式が不正です');
      unawaited(
        _analytics.logEvent(
          eventName: AnalyticsEvent.registrationFailed,
          parameters: {
            ...defaultParams,
            'nicknameValidationError': state.nickname.displayError ?? '',
            'birthdayValidationError': state.birthday.displayError ?? '',
          },
        ),
      );
      unawaited(_crashlytics.recordError(e, null));
      return;
    }

    final user = _ref.read(userStateProvider)!;
    final updatedUser =
        user.fromRegistrationForm(state.nickname.text, state.gender.selectedValue, birthday);
    await (() async {
      _userStateNotifier.state = updatedUser;
    })();
    final result = await _usecase.execute(user: updatedUser, isRegistered: isRegistered);

    switch (result.status) {
      // ユーザ登録に成功したらユーザの state を更新
      case RegistrationResultStatus.success:
        if (isRegistered) {
          // 登録済みの場合はloginStateが更新されないので、強制的にページ遷移させる
          _ref.read(pageTypeProvider.notifier).state = PageType.home;
          _ref.read(routerProvider).go(RouterPath.home);
        } else {
          _loginStateNotifier.state = updatedUser.userStatus;
        }
        break;
      case RegistrationResultStatus.alreadyExistSameNicknameUser:
        state = state.setExternalErrors(nicknameError: '既に使われているため別のニックネームにしてください');
        unawaited(
          _analytics.logEvent(
            eventName: AnalyticsEvent.registrationFailed,
            parameters: {...defaultParams, 'status': result.status.name},
          ),
        );
        unawaited(_crashlytics.recordError(result.error, null));
        break;
      case RegistrationResultStatus.fail:
        unawaited(
          _analytics.logEvent(
            eventName: AnalyticsEvent.registrationFailed,
            parameters: {...defaultParams, 'status': result.status.name},
          ),
        );
        unawaited(_crashlytics.recordError(result.error, null));
        break;
    }
  }

  Future<void> onPressedLogout() async {
    await _ref.read(analyticsProvider).logEvent(eventName: AnalyticsEvent.logout);
    await _ref.read(signInUsecaseProvider).logout();
    _ref.read(loginStateProvider.notifier).state = null;
    _ref.read(routerProvider).go(RouterPath.signIn);
  }
}

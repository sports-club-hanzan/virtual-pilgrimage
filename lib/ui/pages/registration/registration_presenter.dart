import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/user/registration/registration_result.dart';
import 'package:virtualpilgrimage/domain/user/registration/user_registration_usecase.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';
import 'package:virtualpilgrimage/model/radio_button_model.codegen.dart';
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
            gender: RadioButtonModel.of<Gender>(
              ['未設定', '男性', '女性'],
              Gender.values,
              user?.gender,
            ),
            birthDay: user != null ? user.birthDay : DateTime.utc(1980),
          ),
        ) {
    _usecase = _ref.read(userRegistrationUsecaseProvider);
    _analytics = _ref.read(analyticsProvider);
  }

  final Ref _ref;
  late final UserRegistrationUsecase _usecase;
  late final Analytics _analytics;

  void initialize(String nickname, DateTime birthday) {
    state = RegistrationState(
      nickname: FormModel.of(nicknameValidator, nickname),
      gender: RadioButtonModel.of<Gender>(['未設定', '男性', '女性'], Gender.values),
      birthDay: birthday,
    );
  }

  void onChangedNickname(FormModel nickname) {
    state.gender.unfocus();
    state = state.copyWith(nickname: nickname);
  }

  void onChangedGender(Gender? gender) {
    state.nickname.unfocus();
    state = state.copyWith(
      gender: state.gender.copyWith(selectedValue: gender!),
    );
  }

  void onPressedDate(BuildContext context) {
    state.nickname.unfocus();
    state.gender.unfocus();
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(CustomizableDateTime.current.year - 100, 1, 1),
      maxTime: CustomizableDateTime.current,
      onConfirm: (date) => state = state.copyWith(birthDay: date),
      locale: LocaleType.jp,
      currentTime: state.birthDay,
    );
  }

  Future<void> onPressedRegistration() async {
    final defaultParams = {
      'nickname': state.nickname.text,
      'gender': state.gender.selectedValue.name,
      'birthday': state.birthDay.toIso8601String(),
    };
    await _analytics.logEvent(
      eventName: AnalyticsEvent.pressedRegistration,
      parameters: defaultParams,
    );
    state = state.onSubmit();
    // バリデーションエラーにかかっている場合はリクエストを送らない
    if (!state.nickname.isValid) {
      unawaited(
        _analytics.logEvent(
          eventName: AnalyticsEvent.registrationFailed,
          parameters: {
            ...defaultParams,
            'nicknameValidationError': state.nickname.displayError,
          },
        ),
      );
      return;
    }

    final user = _ref.read(userStateProvider);
    if (user == null) {
      return;
    }

    final updatedUser = user.copyWith(
      nickname: state.nickname.text,
      gender: state.gender.selectedValue,
      birthDay: state.birthDay,
      userStatus: UserStatus.created, // 作成済みステータスに変える
    );
    final result = await _usecase.execute(updatedUser);
    // TODO(s14t284): result の出しわけに応じて画面の表示を変える
    switch (result.status) {
      // ユーザ登録に成功したらユーザの state を更新
      case RegistrationResultStatus.success:
        _ref.read(userStateProvider.state).state = updatedUser;
        _ref.read(loginStateProvider.state).state = updatedUser.userStatus;
        break;
      case RegistrationResultStatus.alreadyExistSameNicknameUser:
        state = state.copyWith(
          nickname: state.nickname.addExternalError('既に使われているため別のニックネームにしてください'),
        );
        unawaited(
          _analytics.logEvent(
            eventName: AnalyticsEvent.registrationFailed,
            parameters: {
              ...defaultParams,
              'status': result.status.name,
            },
          ),
        );
        break;
      case RegistrationResultStatus.fail:
        unawaited(
          _analytics.logEvent(
            eventName: AnalyticsEvent.registrationFailed,
            parameters: {
              ...defaultParams,
              'status': result.status.name,
            },
          ),
        );
        break;
    }
  }
}

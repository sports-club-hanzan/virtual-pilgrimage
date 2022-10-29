import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';
import 'package:virtualpilgrimage/model/radio_button_model.codegen.dart';

part 'registration_state.codegen.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    required FormModel nickname,
    required FormModel birthday,
    required RadioButtonModel<Gender> gender,
  }) = _RegistrationState;

  const RegistrationState._();

  RegistrationState onSubmit() =>
      copyWith(nickname: nickname.onSubmit(), birthday: birthday.onSubmit());

  /// ニックネームフォームを更新
  RegistrationState onChangeNickname(FormModel form) => copyWith(
        nickname: form.copyWith(externalErrors: []),
        birthday: birthday.copyWith(externalErrors: []),
      );

  /// 誕生日フォームを更新
  RegistrationState onChangeBirthday(FormModel form) => copyWith(
        nickname: nickname.copyWith(externalErrors: []),
        birthday: form.copyWith(externalErrors: []),
      );

  /// 性別選択タブをタップ
  RegistrationState onTapGenderButton(Gender value) {
    nickname.unfocus();
    birthday.unfocus();
    return copyWith(gender: gender.copyWith(selectedValue: value));
  }

  /// バリデーションエラーを登録
  RegistrationState setExternalErrors({String nicknameError = '', String birthdayError = ''}) {
    return copyWith(
      nickname: nickname.addExternalError(nicknameError),
      birthday: birthday.addExternalError(birthdayError),
    );
  }
}

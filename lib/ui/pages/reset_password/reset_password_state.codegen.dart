import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';

part 'reset_password_state.codegen.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  factory ResetPasswordState({
    required FormModel email,
  }) = _ResetPasswordState;

  const ResetPasswordState._();

  bool isValidAll() => email.isValid;

  /// 送信状態に変更
  ResetPasswordState onSubmit() => copyWith(email: email.onSubmit());

  /// メールアドレスを入力するフォームを更新
  ResetPasswordState onChangeEmail(FormModel form) =>
      copyWith(email: form.copyWith(externalErrors: []));
}

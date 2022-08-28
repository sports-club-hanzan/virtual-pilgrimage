import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';

part 'sign_in_state.codegen.freezed.dart';

enum SignInStateContext {
  // サインインに成功している状態
  success,
  // サインインに成功しているが、初期設定が終わっていない
  temporary,
  // サインインに失敗
  failed,
  // サインインしていない
  notSignedIn
}

@freezed
class SignInState with _$SignInState {
  const SignInState._();

  const factory SignInState({
    @Default(SignInStateContext.failed) SignInStateContext context,
    @Default(false) bool isLoading,
    Exception? error,
    required FormModel email,
    required FormModel password,
  }) = _SignInState;

  bool isValidAll() => email.isValid && password.isValid;

  SignInState onSubmit() =>
      copyWith(email: email.onSubmit(), password: password.onSubmit());
}

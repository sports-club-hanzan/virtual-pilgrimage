import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/ui/model/form_model.codegen.dart';

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
  const factory SignInState({
    @Default(SignInStateContext.failed) SignInStateContext context,
    @Default(false) bool isLoading,
    required FormModel emailOrNickname,
    required FormModel password,
  }) = _SignInState;

  const SignInState._();

  bool isValidAll() => emailOrNickname.isValid && password.isValid;

  SignInState onSubmit() =>
      copyWith(emailOrNickname: emailOrNickname.onSubmit(), password: password.onSubmit());

  /// メールアドレスまたはニックネームを入力するフォームを更新
  SignInState onChangeEmailOrNickname(FormModel form) => copyWith(
        emailOrNickname: form.copyWith(externalErrors: []),
        password: password.copyWith(externalErrors: []),
      );

  /// パスワードを入力するフォームを更新
  SignInState onChangePassword(FormModel form) => copyWith(
        emailOrNickname: emailOrNickname.copyWith(externalErrors: []),
        password: form.copyWith(externalErrors: []),
      );

  /// バリデーションエラーを登録
  SignInState setExternalErrors({String emailOrNicknameError = '', String passwordError = ''}) {
    return copyWith(
      emailOrNickname: emailOrNickname.addExternalError(emailOrNicknameError),
      password: password.addExternalError(passwordError),
    );
  }

  /// サインイン状態をセット(現状は活用されていない)
  SignInState setContext(SignInStateContext context) => copyWith(context: context);
}

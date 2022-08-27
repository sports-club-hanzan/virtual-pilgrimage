import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

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
    VirtualPilgrimageUser? user,
    Exception? error,
  }) = _SignInState;
}

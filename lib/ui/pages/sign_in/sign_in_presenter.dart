import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_state.codegen.dart';

final signInPresenterProvider =
    StateNotifierProvider.autoDispose<SignInPresenter, SignInState>(
  (ref) => SignInPresenter(
    ref,
  ),
);

class SignInPresenter extends StateNotifier<SignInState> {
  final Ref _ref;
  late final SignInUsecase _signInUsecase;
  late final StateController<VirtualPilgrimageUser?> _userState;

  SignInPresenter(
    this._ref,
  ) : super(SignInState(
          context: SignInStateContext.notSignedIn,
          email: FormModel.of(emailValidator),
          password: FormModel.of(passwordValidator),
        )) {
    _signInUsecase = _ref.read(signInUsecaseProvider);
    _userState = _ref.watch(userStateProvider.state);
  }

  void onChangeEmail(FormModel email) => state = state.copyWith(email: email);

  void onChangePassword(FormModel password) =>
      state = state.copyWith(password: password);

  Future<void> signInWithGoogle() async {
    try {
      final user = await _signInUsecase.signInWithGoogle();
      state = SignInState(
        context: _getSignInContext(user),
        email: state.email,
        password: state.password,
      );
      // userState を変更するとページが遷移するので最後に更新を実行
      _userState.state = user;
    } on Exception catch (e) {
      state = state.copyWith(
        error: e,
      );
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    state = state.onSubmit();
    // バリデーションエラーにかかっている場合はリクエストを送らない
    if (!state.email.isValid || !state.password.isValid) {
      return;
    }

    try {
      final user = await _signInUsecase.signInWithEmailAndPassword(
          state.email.text, state.password.text);
      state = SignInState(
        context: _getSignInContext(user),
        email: state.email,
        password: state.password,
      );
      // userState を変更するとページが遷移するので最後に更新を実行
      _userState.state = user;
    } on SignInException catch (e) {
      switch (e.status) {
        case SignInExceptionStatus.credentialIsNull:
        case SignInExceptionStatus.credentialUserIsNull:
          state.email.addExternalError("認証情報が空でした。認証に利用するメールアドレスを見直してください");
          break;
        case SignInExceptionStatus.emailOrPasswordIsNull:
          // 設定しているもののvalidationで弾かれるため、ここには分岐しないはず
          state.email.addExternalError("メールアドレス・ニックネームまたはパスワードを入力してください");
          state.password.addExternalError("メールアドレス・ニックネームまたはパスワードを入力してください");
          break;
        case SignInExceptionStatus.firebaseException:
        case SignInExceptionStatus.unknownException:
          state.email.addExternalError("サインイン時に想定外のエラーが発生しました");
          break;
        case SignInExceptionStatus.platformException:
          state.email.addExternalError("お使いの端末のバージョンではアプリを利用できない可能性があります");
          break;
        case SignInExceptionStatus.wrongPassword:
          state.password.addExternalError("パスワードが誤っています");
          break;
      }
      state = state.copyWith(
        error: e,
      );
    } on Exception catch (e) {
      state = state.copyWith(
        error: e,
      );
    }
  }

  // TODO: 他のページやstateに実装する
  Future<void> logout() async {
    await _signInUsecase.logout();
    _ref.watch(userStateProvider.state).state = null;
  }

  SignInStateContext _getSignInContext(VirtualPilgrimageUser user) {
    switch (user.userStatus) {
      case UserStatus.temporary:
        return SignInStateContext.temporary;
      case UserStatus.success:
        return SignInStateContext.success;
      case UserStatus.deleted:
        return SignInStateContext.failed;
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_state.codegen.dart';

final signInControllerProvider =
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
  ) : super(
          const SignInState(
            context: SignInStateContext.notSignedIn,
            isLoading: true,
          ),
        ) {
    _signInUsecase = _ref.read(signInUsecaseProvider);
    _userState = _ref.watch(userStateProvider.state);
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await _signInUsecase.signInWithGoogle();
      state = SignInState(
        context: _getSignInContext(user),
      );
      // userState を変更するとページが遷移するので最後に更新を実行
      _userState.state = user;
    } on Exception catch (e) {
      state = SignInState(
        error: e,
      );
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _signInUsecase.signInWithGoogle();
      state = SignInState(
        context: _getSignInContext(user),
      );
      // userState を変更するとページが遷移するので最後に更新を実行
      _userState.state = user;
    } on Exception catch (e) {
      state = SignInState(
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

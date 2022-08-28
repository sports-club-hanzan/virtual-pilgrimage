import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_state.codegen.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_auth_provider.dart';
import 'package:virtualpilgrimage/logger.dart';

final signInControllerProvider =
    StateNotifierProvider.autoDispose<SignInController, SignInState>(
  (ref) => SignInController(
    ref.watch(emailAndPasswordAuthRepositoryProvider),
    ref.watch(googleAuthRepositoryProvider),
    ref.watch(userRepositoryProvider),
    ref.watch(loggerProider),
    ref.watch(crashlyticsProvider),
    ref.watch(firebaseAuthProvider),
    ref.watch(userStateProvider.state),
  ),
);

enum _LoginMethod {
  emailAndPassword,
  google,
}

class SignInController extends StateNotifier<SignInState> {
  final AuthRepository _emailAndPasswordAuthRepository;
  final AuthRepository _googleAuthRepository;
  final UserRepository _userRepository;
  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;
  final FirebaseAuth _firebaseAuth;
  final StateController<VirtualPilgrimageUser?> userState;

  SignInController(
    this._emailAndPasswordAuthRepository,
    this._googleAuthRepository,
    this._userRepository,
    this._logger,
    this._crashlytics,
    this._firebaseAuth,
    this.userState,
  ) : super(
          const SignInState(
            context: SignInStateContext.notSignedIn,
            isLoading: true,
          ),
        );

  Future<void> signInWithGoogle() async {
    final credential = await _googleAuthRepository.signIn();
    // Firebase から取得した Credential 情報の null check
    if (credential == null || credential.user == null) {
      const message = 'signin with google result is null';
      _logger.e(
        message,
      );
      _crashlytics.log(message);
      state = SignInState(
        error: SignInException(
          message,
          SignInExceptionStatus.credentialIsNull,
        ),
      );
      return;
    }
    final credentialUser = credential.user!;

    state = await _signInWithCredentialUser(
      credentialUser,
      _LoginMethod.google,
    );
    _crashlytics.setUserIdentifier(credentialUser.uid);
    userState.state = state.user;
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _emailAndPasswordAuthRepository.signIn(
      email: email,
      password: password,
    );
    // Firebase から取得した Credential 情報の null check
    if (credential == null || credential.user == null) {
      const message = 'signin with google result is null';
      _logger.e(
        message,
      );
      _crashlytics.log(message);
      state = SignInState(
        error: SignInException(
          message,
          SignInExceptionStatus.credentialIsNull,
        ),
      );
      return;
    }
    final credentialUser = credential.user!;

    state = await _signInWithCredentialUser(
      credentialUser,
      _LoginMethod.emailAndPassword,
    );
    _crashlytics.setUserIdentifier(credentialUser.uid);
    // userState を変更するとページが遷移するので最後に更新を実行
    userState.state = state.user;
  }

  // TODO: 他のページやstateに実装する
  Future<void> logout() async {
    state = const SignInState(
      context: SignInStateContext.notSignedIn,
    );
    // FIXME: firebase を直参照ではなく、もっといい方法を考える
    await _firebaseAuth.signOut();
    userState.state = null;
  }

  Future<SignInState> _signInWithCredentialUser(
    User credentialUser,
    _LoginMethod loginMethod,
  ) async {
    final signInMessage =
        'signin with $loginMethod [userId][${credentialUser.uid}][email][${credentialUser.email ?? ''}]';
    _logger.i(signInMessage);
    _crashlytics.log(signInMessage);

    // ユーザー情報を作成
    VirtualPilgrimageUser user;
    SignInStateContext context = SignInStateContext.failed;
    try {
      VirtualPilgrimageUser? gotUser =
          await _userRepository.get(credentialUser.uid);
      // ユーザーがまだ作成されていない場合、デフォルト値を埋めてFirestoreに保存
      if (gotUser == null) {
        user = VirtualPilgrimageUser(
          id: credentialUser.uid,
          nickname: credentialUser.displayName ?? '',
          birthDay: DateTime.utc(1980, 1, 1),
          email: credentialUser.email!, // email はどのログイン方法でも必ず存在するはず
          userIconUrl: credentialUser.photoURL ?? '',
          userStatus: UserStatus.temporary,
        );
        await _userRepository.update(user);
        context = SignInStateContext.temporary;
      } else {
        user = gotUser;
        // 一次登録完了ステータスの場合はユーザ登録に遷移するため temporary
        if (gotUser.userStatus == UserStatus.temporary) {
          context = SignInStateContext.temporary;
        } else {
          context = SignInStateContext.success;
        }
      }
    } on DatabaseException catch (e) {
      _logger.e(e.message, [e]);
      if (e.message != null) {
        _crashlytics.log(e.message!);
      }
      final causeException = e.cause;
      final StackTrace? stackTrace = causeException is FirebaseException
          ? causeException.stackTrace
          : null;
      _crashlytics.recordError(
        e,
        stackTrace,
        reason: 'DatabaseException',
      );

      return SignInState(
        error: e,
      );
    } on Exception catch (e) {
      final message =
          'get user or initialize user is error [uid][${credentialUser.uid}]';
      _logger.e(message, [e]);
      _crashlytics.log(message);

      return SignInState(
        error: DatabaseException(
          message: message,
          cause: e,
        ),
      );
    }

    return SignInState(
      context: context,
      user: user,
    );
  }
}

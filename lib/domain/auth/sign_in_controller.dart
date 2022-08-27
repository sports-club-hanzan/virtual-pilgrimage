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
import 'package:virtualpilgrimage/logger.dart';

final signInController =
    StateNotifierProvider.autoDispose<SignInController, SignInState>(
  (ref) => SignInController(
    ref.watch(emailAndPasswordAuthRepositoryProvider),
    ref.watch(googleAuthRepositoryProvider),
    ref.watch(userRepositoryProvider),
    ref.watch(loggerProider),
    ref.watch(crashlyticsProvider),
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

  SignInController(
    this._emailAndPasswordAuthRepository,
    this._googleAuthRepository,
    this._userRepository,
    this._logger,
    this._crashlytics,
  ) : super(
          const SignInState(
            context: SignInStateContext.notSignedIn,
            isLoading: true,
          ),
        );

  Future<SignInState> signInWithGoogle() async {
    final credential = await _googleAuthRepository.signIn();
    return _signInWithCredential(credential, _LoginMethod.google);
  }

  Future<SignInState> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _emailAndPasswordAuthRepository.signIn(
      email: email,
      password: password,
    );
    return _signInWithCredential(credential, _LoginMethod.emailAndPassword);
  }

  Future<SignInState> _signInWithCredential(
    UserCredential? credential,
    _LoginMethod loginMethod,
  ) async {
    // Firebase から取得した Credential 情報の null check
    if (credential == null || credential.user == null) {
      const message = 'signin with google result is null';
      _logger.e(
        message,
      );
      _crashlytics.log(message);
      return SignInState(
        error: SignInException(
          message,
          SignInExceptionStatus.credentialIsNull,
        ),
      );
    }

    final credentialUser = credential.user!;
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

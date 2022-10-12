import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
import 'package:virtualpilgrimage/domain/user/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/user_icon_repository.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

enum _LoginMethod {
  emailAndPassword,
  google,
}

class SignInInteractor extends SignInUsecase {
  SignInInteractor(
    this._emailAndPasswordAuthRepository,
    this._googleAuthRepository,
    this._userRepository,
    this._userIconRepository,
    this._logger,
    this._crashlytics,
    this._firebaseAuth,
  );

  final AuthRepository _emailAndPasswordAuthRepository;
  final AuthRepository _googleAuthRepository;
  final UserRepository _userRepository;
  final UserIconRepository _userIconRepository;
  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<VirtualPilgrimageUser> signInWithGoogle() async {
    final credential = await _googleAuthRepository.signIn();
    // Firebase から取得した Credential 情報の null check
    if (credential == null || credential.user == null) {
      const message = 'signin with google result is null';
      _logger.e(
        message,
      );
      await _crashlytics.log(message);
      throw SignInException(
        message: message,
        status: SignInExceptionStatus.credentialIsNull,
      );
    }
    final credentialUser = credential.user!;

    await _crashlytics.setUserIdentifier(credentialUser.uid);
    return _signInWithCredentialUser(
      credentialUser,
      _LoginMethod.google,
    );
  }

  @override
  Future<VirtualPilgrimageUser> signInWithEmailAndPassword(
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
      await _crashlytics.log(message);
      throw SignInException(
        message: message,
        status: SignInExceptionStatus.credentialIsNull,
      );
    }
    final credentialUser = credential.user!;

    await _crashlytics.setUserIdentifier(credentialUser.uid);
    return _signInWithCredentialUser(
      credentialUser,
      _LoginMethod.emailAndPassword,
    );
  }

  @override
  Future<void> logout() async {
    // TODO(s14t284): firebase を直参照ではなく、もっといい方法を考える
    await _firebaseAuth.signOut();
  }

  Future<VirtualPilgrimageUser> _signInWithCredentialUser(
    User credentialUser,
    _LoginMethod loginMethod,
  ) async {
    final signInMessage = 'signin with $loginMethod'
        '[userId][${credentialUser.uid}]'
        '[email][${credentialUser.email ?? ''}]';
    _logger.i(signInMessage);
    await _crashlytics.log(signInMessage);

    // ユーザー情報を作成
    VirtualPilgrimageUser user;
    try {
      final gotUser = await _userRepository.get(credentialUser.uid);
      // ユーザーがまだ作成されていない場合、デフォルト値を埋めてFirestoreに保存
      if (gotUser == null) {
        final now = CustomizableDateTime.current;
        user = VirtualPilgrimageUser(
          id: credentialUser.uid,
          // nickname はユーザ登録フォームで入力するので空の値を指定
          nickname: '',
          birthDay: DateTime.utc(1980, 1, 1),
          email: credentialUser.email!,
          // email はどのログイン方法でも必ず存在するはず
          userIconUrl: credentialUser.photoURL ?? '',
          userStatus: UserStatus.temporary,
          createdAt: now,
          updatedAt: now,
          pilgrimage: PilgrimageInfo(
            id: credentialUser.uid,
            updatedAt: now,
          ),
        );
        await _userRepository.update(user);
      } else {
        user = gotUser;
      }
      if (user.userIconUrl.isNotEmpty) {
        final BitmapDescriptor image = await _userIconRepository.loadIconImage(user.userIconUrl);
        user = user.copyWith(
          userIcon: image,
        );
      }
    } on DatabaseException catch (e) {
      _logger.e(e.message, [e]);
      await _crashlytics.log(e.message);
      final causeException = e.cause;
      final stackTrace = causeException is FirebaseException ? causeException.stackTrace : null;
      await _crashlytics.recordError(
        e,
        stackTrace,
        reason: 'DatabaseException',
      );

      throw SignInException(
        message: e.message,
        status: SignInExceptionStatus.firebaseException,
        cause: e,
      );
    } on Exception catch (e) {
      final message = 'get user or initialize user is error [uid][${credentialUser.uid}]';
      _logger.e(message, [e]);
      await _crashlytics.log(message);
      await _crashlytics.recordError(
        e,
        null,
        reason: 'Exception',
      );

      throw SignInException(
        message: message,
        status: SignInExceptionStatus.unknownException,
        cause: e,
      );
    }

    return user;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/application/auth/auth_repository.dart';
import 'package:virtualpilgrimage/application/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
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
  final Logger _logger;
  final FirebaseCrashlytics _crashlytics;
  final FirebaseAuth _firebaseAuth;

  // ignore: unused_field
  final UserIconRepository _userIconRepository;

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
        user = VirtualPilgrimageUser.initializeForSignIn(credentialUser);
        await _userRepository.update(user);
      } else {
        user = gotUser;
      }

      // ユーザが設定した画像をピンに使うと表示位置がずれるなどUI上の課題があるので一旦コメントアウト
      // FIXME: ピンにユーザが設定した画像を使う方針にするか、使わない方針にするか議論する
      // if (user.userIconUrl.isNotEmpty) {
      //   final BitmapDescriptor bitmap = await _userIconRepository.loadIconImage(user.userIconUrl);
      //   user = user.setUserIconBitmap(bitmap);
      // }
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

  @override
  Future<VirtualPilgrimageUser> signInWithNicknameAndPassword(
    String nickname,
    String password,
  ) async {
    late final VirtualPilgrimageUser? user;
    try {
      // ログインしていないが先にユーザ情報を検索し、そのニックネームが存在するか確認する
      user = await _userRepository.findWithNickname(nickname);
    } on DatabaseException catch (e) {
      // 初回の検索時の例外ハンドリングだけはこのメソッド内に実装
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
    }

    if (user == null) {
      throw SignInException(
        message: 'failed to find user for login with nickname and password [nickname][$nickname}]',
        status: SignInExceptionStatus.userNotFoundException,
      );
    }

    // ニックネームが存在している場合、検索時に取得できたメールアドレスを使って認証する
    // 例外処理もこのメソッドの中で実装されているため必要なし
    return signInWithEmailAndPassword(user.email, password);
  }
}

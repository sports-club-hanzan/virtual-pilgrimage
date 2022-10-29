import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/logger.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_state.codegen.dart';

final signInPresenterProvider = StateNotifierProvider.autoDispose<SignInPresenter, SignInState>(
  SignInPresenter.new,
);

class SignInPresenter extends StateNotifier<SignInState> {
  SignInPresenter(
    this._ref,
  ) : super(
          SignInState(
            context: SignInStateContext.notSignedIn,
            emailOrNickname: FormModel.of(requiredValidator),
            password: FormModel.of(passwordValidator),
          ),
        ) {
    _signInUsecase = _ref.read(signInUsecaseProvider);
    _userState = _ref.watch(userStateProvider.state);
    _loginState = _ref.watch(loginStateProvider.state);
    _analytics = _ref.read(analyticsProvider);
  }

  final Ref _ref;
  late final SignInUsecase _signInUsecase;
  late final StateController<VirtualPilgrimageUser?> _userState;
  late final StateController<UserStatus?> _loginState;
  late final Analytics _analytics;

  void onChangeEmail(FormModel emailOrNickname) =>
      state = state.onChangeEmailOrNickname(emailOrNickname);

  void onChangePassword(FormModel password) => state = state.onChangePassword(password);

  Future<void> signInWithGoogle() async {
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.signInWithGoogle));
    try {
      final user = await _signInUsecase.signInWithGoogle();
      state = SignInState(
        context: _getSignInContext(user),
        emailOrNickname: state.emailOrNickname,
        password: state.password,
      );
      unawaited(_analytics.setUserProperties(user: user));
      _updateState(user, user.userStatus);
    } on Exception catch (e) {
      _ref.read(loggerProvider).e(e);
      unawaited(
        _analytics.logEvent(
          eventName: AnalyticsEvent.signInWithGoogleFailed,
          parameters: {'error': e},
        ),
      );
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    await _analytics.logEvent(
      eventName: AnalyticsEvent.signInWithEmailAndPassword,
      parameters: {
        'email': state.emailOrNickname.text,
        'passwordLength': state.password.text.length
      },
    );
    state = state.onSubmit();
    // バリデーションエラーにかかっている場合はリクエストを送らない
    if (!state.isValidAll()) {
      unawaited(
        _analytics.logEvent(
          eventName: AnalyticsEvent.signInWithEmailAndPasswordFailed,
          parameters: {
            'email': state.emailOrNickname.text,
            'passwordLength': state.password.text.length,
            'emailValidationError': state.emailOrNickname.displayError,
            'passwordValidationError': state.password.displayError,
          },
        ),
      );
      return;
    }

    try {
      late final VirtualPilgrimageUser user;
      if (emailValidator(state.emailOrNickname.text) != null) {
        // null じゃないときメールアドレス形式でない ≒ ニックネームのはずなので、ニックネームで検索
        user = await _signInUsecase.signInWithNicknameAndPassword(
          state.emailOrNickname.text,
          state.password.text,
        );
      } else {
        // email validation で null だった場合はメールアドレスの形式を満たしているので、ユーザ情報が存在するか確認
        user = await _signInUsecase.signInWithEmailAndPassword(
          state.emailOrNickname.text,
          state.password.text,
        );
      }
      state = state.setContext(_getSignInContext(user));
      unawaited(_analytics.setUserProperties(user: user));
      _updateState(user, user.userStatus);
    } on SignInException catch (e) {
      switch (e.status) {
        case SignInExceptionStatus.credentialIsNull:
        case SignInExceptionStatus.credentialUserIsNull:
          state = state.setExternalErrors(
            emailOrNicknameError: '認証情報が空でした。認証に利用するメールアドレスを見直してください',
          );
          break;
        case SignInExceptionStatus.emailOrPasswordIsNull:
          // 設定しているもののvalidationで弾かれるため、ここには分岐しないはず
          const errorMsg = 'メールアドレス・ニックネームまたはパスワードを入力してください';
          state = state.setExternalErrors(emailOrNicknameError: errorMsg, passwordError: errorMsg);
          break;
        case SignInExceptionStatus.firebaseException:
        case SignInExceptionStatus.unknownException:
          const errorMsg = 'サインイン時に想定外のエラーが発生しました';
          state = state.setExternalErrors(emailOrNicknameError: errorMsg, passwordError: errorMsg);
          break;
        case SignInExceptionStatus.platformException:
          const errorMsg = 'お使いの端末のバージョンではアプリを利用できない可能性があります';
          state = state.setExternalErrors(emailOrNicknameError: errorMsg, passwordError: errorMsg);
          break;
        case SignInExceptionStatus.wrongPassword:
          const errorMsg = 'メールアドレス・ニックネームまたはパスワードが誤っています';
          state = state.setExternalErrors(emailOrNicknameError: errorMsg, passwordError: errorMsg);
          break;
        case SignInExceptionStatus.weakPassword:
          // バリデーション側で弾いているため、ここには遷移しないはず
          state = state.setExternalErrors(passwordError: '半角英数字8文字以上で入力してください');
          break;
        case SignInExceptionStatus.alreadyUsedEmail:
          state = state.setExternalErrors(emailOrNicknameError: 'そのメールアドレスは既に利用されています');
          break;
        case SignInExceptionStatus.userNotFoundException:
          state = state.setExternalErrors(
            emailOrNicknameError: 'そのユーザは存在しません。新規アカウント作成時はメールアドレスで認証してください',
          );
          break;
      }
      unawaited(
        _analytics.logEvent(
          eventName: AnalyticsEvent.signInWithEmailAndPasswordFailed,
          parameters: {'error': e, 'validationStatus': e.status.name},
        ),
      );
    } on Exception catch (e) {
      unawaited(
        _analytics.logEvent(
          eventName: AnalyticsEvent.signInWithEmailAndPasswordFailed,
          parameters: {'error': e},
        ),
      );
    }
  }

  SignInStateContext _getSignInContext(VirtualPilgrimageUser user) {
    switch (user.userStatus) {
      case UserStatus.temporary:
        return SignInStateContext.temporary;
      case UserStatus.created:
        return SignInStateContext.success;
      case UserStatus.deleted:
        return SignInStateContext.failed;
    }
  }

  void _updateState(VirtualPilgrimageUser? user, UserStatus? loginStatus) {
    _userState.state = user;
    // loginState を変更するとページが遷移するので更新順を後ろにしている
    _loginState.state = loginStatus;
  }
}

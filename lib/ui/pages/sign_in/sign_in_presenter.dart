import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_usecase.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
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

  void onChangeEmail(FormModel emailOrNickname) => state = state.copyWith(
        emailOrNickname: emailOrNickname,
      );

  void onChangePassword(FormModel password) => state = state.copyWith(password: password);

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
      state = state.copyWith(
        error: e,
      );
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
      state = state.copyWith(
        context: _getSignInContext(user),
      );
      unawaited(_analytics.setUserProperties(user: user));
      _updateState(user, user.userStatus);
    } on SignInException catch (e) {
      switch (e.status) {
        case SignInExceptionStatus.credentialIsNull:
        case SignInExceptionStatus.credentialUserIsNull:
          state = state.copyWith(
            emailOrNickname:
                state.emailOrNickname.addExternalError('認証情報が空でした。認証に利用するメールアドレスを見直してください'),
          );
          break;
        case SignInExceptionStatus.emailOrPasswordIsNull:
          // 設定しているもののvalidationで弾かれるため、ここには分岐しないはず
          state = state.copyWith(
            emailOrNickname:
                state.emailOrNickname.addExternalError('メールアドレス・ニックネームまたはパスワードを入力してください'),
            password: state.password.addExternalError('メールアドレス・ニックネームまたはパスワードを入力してください'),
          );
          break;
        case SignInExceptionStatus.firebaseException:
        case SignInExceptionStatus.unknownException:
          state = state.copyWith(
            emailOrNickname: state.emailOrNickname.addExternalError('サインイン時に想定外のエラーが発生しました'),
          );
          break;
        case SignInExceptionStatus.platformException:
          state = state.copyWith(
            emailOrNickname:
                state.emailOrNickname.addExternalError('お使いの端末のバージョンではアプリを利用できない可能性があります'),
          );
          break;
        case SignInExceptionStatus.wrongPassword:
          state = state.copyWith(
            password: state.password.addExternalError('パスワードが誤っています'),
          );
          break;
        case SignInExceptionStatus.weakPassword:
          // バリデーション側で弾いているため、ここには遷移しないはず
          state = state.copyWith(
            password: state.password.addExternalError('半角英数字8文字以上で入力してください'),
          );
          break;
        case SignInExceptionStatus.alreadyUsedEmail:
          state = state.copyWith(
            emailOrNickname: state.password.addExternalError('そのメールアドレスは既に利用されています'),
          );
          break;
        case SignInExceptionStatus.userNotFoundException:
          state = state.copyWith(
            emailOrNickname:
                state.emailOrNickname.addExternalError('そのユーザは存在しません。新規アカウント作成時はメールアドレスで認証してください'),
          );
          break;
      }
      state = state.copyWith(
        error: e,
      );
      unawaited(
        _analytics.logEvent(
          eventName: AnalyticsEvent.signInWithEmailAndPasswordFailed,
          parameters: {'error': e, 'validationStatus': e.status.name},
        ),
      );
    } on Exception catch (e) {
      state = state.copyWith(
        error: e,
      );
      unawaited(
        _analytics.logEvent(
          eventName: AnalyticsEvent.signInWithEmailAndPasswordFailed,
          parameters: {'error': e},
        ),
      );
    }
  }

  // TODO(s14t284): 他のページやstateに実装する
  Future<void> logout() async {
    await _analytics.logEvent(eventName: AnalyticsEvent.logout);
    await _signInUsecase.logout();
    _updateState(null, null);
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

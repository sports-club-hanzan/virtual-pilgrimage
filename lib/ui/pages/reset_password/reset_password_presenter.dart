import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/auth/reset_password_usecase.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/model/form_model.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/reset_password/components/success_reset_password_dialog.dart';
import 'package:virtualpilgrimage/ui/pages/reset_password/reset_password_state.codegen.dart';

import 'components/fail_reset_password_dialog.dart';

final resetPasswordProvider =
    StateNotifierProvider.autoDispose<ResetPasswordPresenter, ResetPasswordState>(
  ResetPasswordPresenter.new,
);

class ResetPasswordPresenter extends StateNotifier<ResetPasswordState> {
  ResetPasswordPresenter(this._ref)
      : super(ResetPasswordState(email: FormModel.of(emailValidator))) {
    _resetUserPasswordUsecase = _ref.read(resetUserPasswordUsecaseProvider);
  }

  final Ref _ref;
  late final ResetUserPasswordUsecase _resetUserPasswordUsecase;

  Future<void> onChangeEmailForm(FormModel form) async {
    state = state.onChangeEmail(form);
  }

  Future<Widget?> onSubmitResetPassword(BuildContext context) async {
    state = state.onSubmit();
    if (!state.isValidAll()) {
      return null;
    }
    final result = await _resetUserPasswordUsecase.execute(email: state.email.text);
    if (result) {
      return const SuccessResetPasswordDialog();
    }
    return const FailResetPasswordDialog();
  }

  Future<void> onSubmitBackwardSignInPage() async {
    _ref.read(routerProvider).go(RouterPath.signIn);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/ui/components/atoms/primary_button.dart';
import 'package:virtualpilgrimage/ui/components/atoms/secondary_button.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/components/my_text_form_field.dart';
import 'package:virtualpilgrimage/ui/pages/reset_password/reset_password_presenter.dart';
import 'package:virtualpilgrimage/ui/pages/reset_password/reset_password_state.codegen.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(isLogin: false),
      body: _ResetPasswordPageBody(ref),
    );
  }
}

class _ResetPasswordPageBody extends StatelessWidget {
  const _ResetPasswordPageBody(this._ref);

  final WidgetRef _ref;

  String get buttonTitle => 'パスワードをリセットする';

  @override
  Widget build(BuildContext context) {
    final state = _ref.watch(resetPasswordProvider);
    final notifier = _ref.read(resetPasswordProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Title(
            color: Theme.of(context).colorScheme.primary,
            child: const Text(
              'パスワードを忘れた場合',
              style: TextStyle(fontSize: FontSize.largeSize, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '以下のフォームに登録したメールアドレスを入力し、「$buttonTitle」ボタンを押してパスワードをリセットしてください',
              style: const TextStyle(fontSize: FontSize.mediumSize),
            ),
          ),
          Column(
            children: [
              _emailForm(state, notifier),
              _resetButton(context, notifier),
              _backwardSignInPageButton(context, notifier)
            ],
          ),
        ],
      ),
    );
  }

  Widget _emailForm(ResetPasswordState state, ResetPasswordPresenter notifier) => SizedBox(
        height: 140,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 24, right: 12, bottom: 24),
          child: MyTextFormField(
            formModel: state.email,
            onChanged: notifier.onChangeEmailForm,
            decoration: const InputDecoration(
              hintText: 'メールアドレス',
              prefixIcon: Icon(Icons.mail_outline),
            ),
            obscureText: false,
            textInputType: TextInputType.emailAddress,
            inputAction: TextInputAction.go,
          ),
        ),
      );

  Widget _resetButton(BuildContext context, ResetPasswordPresenter notifier) => SizedBox(
        width: MediaQuery.of(context).size.width / 10 * 7,
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: PrimaryButton(
            onPressed: () => notifier.onSubmitResetPassword(context),
            text: buttonTitle,
          ),
        ),
      );

  Widget _backwardSignInPageButton(BuildContext context, ResetPasswordPresenter notifier) =>
      SizedBox(
        width: MediaQuery.of(context).size.width / 10 * 7,
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: SecondaryButton(
            onPressed: notifier.onSubmitBackwardSignInPage,
            text: 'ログインページに戻る',
          ),
        ),
      );
}

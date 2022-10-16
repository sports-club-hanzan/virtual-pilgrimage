import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';
import 'package:virtualpilgrimage/ui/components/atoms/primary_button.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/components/my_text_form_field.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SignInPageBody(ref),
    );
  }
}

class SignInPageBody extends StatelessWidget {
  const SignInPageBody(this.ref, {super.key});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(signInPresenterProvider.notifier);
    final state = ref.watch(signInPresenterProvider);

    return Builder(
      builder: (context) {
        return ColoredBox(
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 32, 12, 12),
                  child: _createTextFormField(
                    state.emailOrNickname,
                    notifier.onChangeEmail,
                    const InputDecoration(
                      hintText: 'メールアドレス or ニックネーム',
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                    TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: _createTextFormField(
                    state.password,
                    notifier.onChangePassword,
                    const InputDecoration(
                      hintText: 'パスワード',
                      prefixIcon: Icon(Icons.password_outlined),
                    ),
                    // パスワードの仕様を漏らすのは脆弱性に繋がるが、DB側にパスワードを保存していない（Authentication に保存している）のでわかりやすさ重視
                    TextInputType.visiblePassword,
                    true,
                    TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, right: 8, left: 8, bottom: 8),
                  child: PrimaryButton(
                    onPressed: () async => notifier.signInWithEmailAndPassword(),
                    text: 'サインイン・新規アカウント作成',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'または',
                    style: TextStyle(
                      fontSize: FontSize.mediumSize,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Center(
                    child: SignInButton(
                      Buttons.GoogleDark,
                      text: 'Google でサインイン',
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        await notifier.signInWithGoogle();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _createTextFormField(
    FormModel formModel,
    ValueChanged<FormModel> onChanged,
    InputDecoration decoration,
    TextInputType textInputType, [
    bool obsecureText = false,
    TextInputAction inputAction = TextInputAction.next,
  ]) {
    return MyTextFormField(
      formModel: formModel,
      onChanged: onChanged,
      decoration: decoration,
      obscureText: obsecureText,
      textInputType: textInputType,
      inputAction: inputAction,
    );
  }
}

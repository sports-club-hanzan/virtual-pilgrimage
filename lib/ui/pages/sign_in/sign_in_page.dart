import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:virtualpilgrimage/ui/pages/sign_in/sign_in_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

final emailControllerStateProvider = StateProvider.autoDispose(
  (_) => TextEditingController(text: ''),
);

final passwordControllerStateProvider = StateProvider.autoDispose(
  (_) => TextEditingController(text: ''),
);

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // TODO: タイトルは変更
        title: const Text('virtual pilgrimage'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SignInPageBody(ref),
    );
  }
}

class SignInPageBody extends StatelessWidget {
  final WidgetRef ref;

  const SignInPageBody(this.ref, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(signInControllerProvider.notifier);
    final state = ref.watch(signInControllerProvider);

    final emailFormController = ref.watch(emailControllerStateProvider);
    final passwordFormController = ref.watch(passwordControllerStateProvider);

    return Builder(builder: (context) {
      return Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // ref. https://zenn.dev/pressedkonbu/articles/copy-paste-text-form-field
              Padding(
                padding: const EdgeInsets.only(
                  top: 32.0,
                  right: 12.0,
                  left: 12.0,
                  bottom: 12.0,
                ),
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: FontStyle.mediumSize,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorStyle.white,
                    hintText: 'ニックネーム or メールアドレス',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).unselectedWidgetColor,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  key: const Key('nicknameOrEmail'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ニックネームかメールアドレスを入力してください';
                    }
                    return null;
                  },
                  controller: emailFormController,
                  enabled: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: FontStyle.mediumSize,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorStyle.white,
                    hintText: 'パスワード',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).unselectedWidgetColor,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  key: const Key('password'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  controller: passwordFormController,
                  enabled: true,
                ),
              ),
              // FIXME: PrimaryButton などのコンポーネントに切り出す
              Padding(
                padding: const EdgeInsets.only(
                  top: 32.0,
                  right: 8.0,
                  left: 8.0,
                  bottom: 8.0,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    await notifier.signInWithEmailAndPassword(
                      emailFormController.text,
                      passwordFormController.text,
                    );
                  },
                  // ボタンを押したときの色
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    onPrimary: Theme.of(context).primaryColorDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: FontStyle.mediumSize,
                      // TODO: custom font を導入
                      // ref. https://zenn.dev/susatthi/articles/20220419-143426-flutter-custom-fonts
                      // fontFamily: ""
                    ),
                    padding: const EdgeInsets.all(10.0),
                  ),
                  child: const Text(
                    "ログイン・サインイン",
                    style: TextStyle(color: ColorStyle.text),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "または",
                  style: TextStyle(
                    fontSize: FontStyle.mediumSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  right: 8.0,
                  left: 8.0,
                  bottom: 8.0,
                ),
                child: Center(
                  child: SignInButton(
                    Buttons.GoogleDark,
                    text: "Google でサインイン",
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
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
    });
  }
}

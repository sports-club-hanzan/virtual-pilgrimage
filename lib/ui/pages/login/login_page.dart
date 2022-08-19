import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: タイトルは変更
        title: const Text('virtual pilgrimage'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: const LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SafeArea(
        child: Column(
          children: [
            // ref. https://zenn.dev/pressedkonbu/articles/copy-paste-text-form-field
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                right: 8.0,
                left: 8.0,
                bottom: 8.0,
              ),
              child: TextFormField(
                style: const TextStyle(
                  fontSize: FontStyle.mediumSize,
                ),
                decoration: InputDecoration(
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
                  prefixIcon: const Icon(Icons.mail),
                ),
                key: const Key('nicknameOrEmail'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ニックネームかメールアドレスを入力してください';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(
                  fontSize: FontStyle.mediumSize,
                ),
                decoration: InputDecoration(
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
                  prefixIcon: const Icon(Icons.password),
                ),
                key: const Key('password'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
              ),
            ),
            // FIXME: PrimaryButton などのコンポーネントに切り出す
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 8.0,
                left: 8.0,
                bottom: 8.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  print('TODO');
                },
                // ボタンを押したときの色
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Theme.of(context).primaryColorDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    // TODO: custom font を導入
                    // ref. https://zenn.dev/susatthi/articles/20220419-143426-flutter-custom-fonts
                    // fontFamily: ""
                  ),
                  padding: const EdgeInsets.all(12.0),
                ),
                child: const Text(
                  "ログイン・サインイン",
                  style: TextStyle(color: ColorStyle.text),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

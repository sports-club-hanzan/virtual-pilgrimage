import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

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
            TextFormField(
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
            TextFormField(
              decoration: const InputDecoration(hintText: 'パスワード'),
              key: const Key('password'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
            ),
            // FIXME: PrimaryButton などのコンポーネントに切り出す
            ElevatedButton(
              onPressed: () {
                print('TODO');
              },
              // ボタンを押したときの色
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onPrimary: Theme.of(context).primaryColorDark,
              ),
              child: const Text(
                "ログイン・サインイン",
                style: TextStyle(color: ColorStyle.text),
              ),
            ),
          ],
        ),
      );
    });
  }
}

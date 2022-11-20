import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/router.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class SuccessResetPasswordDialog extends ConsumerWidget {
  const SuccessResetPasswordDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Title(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Text(
          'パスワードのリセットに成功しました',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: FontSize.largeSize,
          ),
        ),
      ),
      content: const Text('パスワードリセットのお知らせがメールに届いているので確認してください'),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: () => ref.read(routerProvider).go(RouterPath.signIn),
            child: const Text('サインイン画面に戻る'),
          ),
        ),
      ],
    );
  }
}

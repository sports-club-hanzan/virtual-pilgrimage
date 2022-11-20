import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class FailResetPasswordDialog extends ConsumerWidget {
  const FailResetPasswordDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Title(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Text(
          'パスワードのリセットに失敗しました',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: FontSize.largeSize,
          ),
        ),
      ),
      content: const Text('入力したメールアドレスが誤っていないか確認してください'),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class FailUploadImageDialog extends ConsumerWidget {
  const FailUploadImageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Title(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Text(
          'プロフィール画像のアップロードに失敗しました',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: FontSize.largeSize,
          ),
        ),
      ),
      content: const Text('もう一度画像を選択してお試しください'),
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

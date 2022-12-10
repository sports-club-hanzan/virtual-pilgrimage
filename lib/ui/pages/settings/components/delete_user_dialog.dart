import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/ui/pages/settings/settings_presenter.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

class DeleteUserDialog extends ConsumerWidget {
  const DeleteUserDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(settingsProvider.notifier);
    final deleteTargetDescriptions = ['プロフィール情報', 'お遍路の進捗状況', 'プロフィール画像']
        .map(
          (e) => Text(
            '・$e',
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
        )
        .toList();
    const circleIconSize = 40.0;

    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            // Bottom rectangular box
            width: MediaQuery.of(context).size.width / 15 * 14,
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'ユーザ情報を削除します',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 16),
                // MEMO: '''で改行を表現しているので、歪だがこのままにしておく必要がある
                Text(
                  '''以下の情報を削除します。
元に戻せませんがよろしいでしょうか？''',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width / 15 * 14,
                  color: ColorStyle.lightGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: deleteTargetDescriptions,
                        ),
                      ],
                    ),
                  ),
                ),
                ButtonBar(
                  buttonMinWidth: 100,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () => notifier.closeDeleteUserDialog(context),
                      child: const Text('キャンセル', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    MaterialButton(
                      onPressed: () {
                        notifier.deleteUserInfo();
                        Navigator.of(context).pop();
                      },
                      color: Theme.of(context).colorScheme.error,
                      child: const Text('削除'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            maxRadius: circleIconSize,
            backgroundColor: Theme.of(context).colorScheme.error,
            child: const Icon(
              Icons.warning_outlined,
              color: Colors.white,
              size: circleIconSize,
            ),
          ),
        ],
      ),
    );
  }
}

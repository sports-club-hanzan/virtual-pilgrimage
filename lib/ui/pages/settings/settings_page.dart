import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/settings/settings_presenter.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: _SettingsPageBody(ref),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class _SettingsPageBody extends StatelessWidget {
  const _SettingsPageBody(this._ref);

  final WidgetRef _ref;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<String> version = _ref.watch(appVersionProvider);
    final notifier = _ref.read(settingsProvider.notifier);

    return SettingsList(
      platform: DevicePlatform.iOS,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      sections: <SettingsSection>[
        SettingsSection(
          title: const Text('基本設定'),
          tiles: <SettingsTile>[
            SettingsTile(
              title: const Text('バージョン'),
              value: Text(version.value ?? '読み込み中'),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('アカウント設定'),
          tiles: <SettingsTile>[
            SettingsTile(
              title: const Text('ユーザ情報編集'),
              onPressed: (BuildContext context) => notifier.moveEditUserInfoPage(),
              leading: const Icon(Icons.edit_outlined),
            ),
            SettingsTile(
              title: const Text('ログアウト'),
              onPressed: (BuildContext context) => notifier.logout(),
              leading: const Icon(Icons.logout_outlined),
            ),
            SettingsTile(
              title: const Text('ユーザ削除'),
              onPressed: notifier.openDeleteUserDialog,
              leading: const Icon(Icons.warning_amber),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('その他'),
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.mail_outline),
              title: const Text('問い合わせ'),
              description: const Text('メールで担当者に問い合わせできます'),
              onPressed: (BuildContext context) => notifier.openMailerForInquiry(),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/molecules/my_drawer.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/settings/settings_presenter.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: MyDrawer.globalScaffoldKey,
      appBar: const MyAppBar(),
      body: _SettingsPageBody(ref),
      bottomNavigationBar: const BottomNavigation(),
      endDrawer: const MyDrawer(),
    );
  }
}

class _SettingsPageBody extends StatelessWidget {
  const _SettingsPageBody(this._ref, {super.key});

  final WidgetRef _ref;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<String> version = _ref.watch(appVersionProvider);
    final notifier = _ref.read(settingsProvider.notifier);
    final dangerTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold);

    return Column(
      children: [
        SettingsList(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          sections: <SettingsSection>[
            SettingsSection(
              title: const Text('基本設定'),
              tiles: <SettingsTile>[
                if (version.value != null)
                  SettingsTile(
                    title: const Text('バージョン'),
                    value: Text(version.value!),
                  )
              ],
            ),
            SettingsSection(
              title: const Text('アカウント設定'),
              tiles: <SettingsTile>[
                SettingsTile(
                  title: SettingsTile.navigation(title: Text('ログアウト', style: dangerTextStyle)),
                  onPressed: (BuildContext context) => notifier.logout(),
                ),
                SettingsTile(
                  title: SettingsTile.navigation(title: Text('ユーザ削除', style: dangerTextStyle)),
                  onPressed: notifier.openDeleteUserDialog,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

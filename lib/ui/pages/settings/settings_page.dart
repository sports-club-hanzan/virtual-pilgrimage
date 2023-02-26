import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/settings/settings_presenter.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  static const policyUrl = 'https://courageous-gumption-d7fd12.netlify.app/policy/';

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
              title: const Text('プロフィール画像変更'),
              onPressed: notifier.updateProfileImage,
              leading: const Icon(Icons.image_outlined),
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
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('プライバシーポリシー'),
              onPressed: (BuildContext context) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyWebView(url: policyUrl)),
              ),
            ),
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

class MyWebView extends StatelessWidget {

  MyWebView({super.key, required this.url}) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
  final String url;

  late final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/ui/pages/settings/settings_page.dart';

import '../../../helper/provider_container.dart';
import '../../../helper/wrap_material_app.dart';

void main() {
  group('SettingsPage', () {
    testWidgets('表示できる', (widgetTester) async {
      await widgetTester.pumpWidget(
        wrapMaterialApp(mockedProviderScope(const SettingsPage())),
      );
      expect(find.text('基本設定'), findsOneWidget);
      expect(find.text('バージョン'), findsOneWidget);
      expect(find.text('アカウント設定'), findsOneWidget);
      expect(find.text('ユーザ情報編集'), findsOneWidget);
      expect(find.text('ログアウト'), findsOneWidget);
      expect(find.text('ユーザ削除'), findsOneWidget);
      expect(find.text('その他'), findsOneWidget);
      expect(find.text('問い合わせ'), findsOneWidget);
    });
  });
}

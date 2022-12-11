import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/ui/pages/settings/components/delete_user_dialog.dart';

import '../../../helper/provider_container.dart';
import '../../../helper/wrap_material_app.dart';

void main() {
  group('DeleteUserDialog', () {
    testWidgets('表示できる', (widgetTester) async {
      await widgetTester.pumpWidget(
        wrapMaterialApp(mockedProviderScope(const DeleteUserDialog())),
      );
      expect(find.text('ユーザ情報を削除します'), findsOneWidget);
      expect(find.text('キャンセル'), findsOneWidget);
      expect(find.text('削除'), findsOneWidget);
    });
  });
}

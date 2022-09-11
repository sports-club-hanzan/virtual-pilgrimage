import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';
import 'package:virtualpilgrimage/ui/components/my_text_form_field.dart';

import '../../helper/wrap_material_app.dart';

void main() {
  group('MyTextFormField', () {
    const key = Key('key');
    testWidgets('表示できる', (widgetTester) async {
      final formModel = FormModel.of((value) => null);
      await widgetTester.pumpWidget(
        wrapMaterialApp(
          MyTextFormField(
            key: key,
            formModel: formModel,
            onChanged: (formModel) => {},
          ),
        ),
      );
      expect(find.byKey(key), findsOneWidget);
    });
    
    testWidgets('フォームを編集できる', (widgetTester) async {
      final formModel = FormModel.of((value) => null);
      await widgetTester.pumpWidget(
        wrapMaterialApp(
          MyTextFormField(
            key: key,
            formModel: formModel,
            onChanged: (formModel) => {},
          ),
        ),
      );
      await widgetTester.enterText(find.byKey(key), 'dummy');

      expect(find.text('dummy'), findsOneWidget);
      expect(formModel.text, 'dummy');
    });
  });
}

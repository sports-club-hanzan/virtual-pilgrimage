import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/application/auth/reset_password_usecase.dart';
import 'package:virtualpilgrimage/ui/components/atoms/primary_button.dart';
import 'package:virtualpilgrimage/ui/components/atoms/secondary_button.dart';
import 'package:virtualpilgrimage/ui/components/my_text_form_field.dart';
import 'package:virtualpilgrimage/ui/pages/reset_password/reset_password_page.dart';

import '../../../helper/mock.mocks.dart';
import '../../../helper/provider_container.dart';
import '../../../helper/wrap_material_app.dart';

void main() {
  group('ResetPasswordPage', () {
    testWidgets('表示できる', (widgetTester) async {
      await widgetTester.pumpWidget(
        wrapMaterialApp(mockedProviderScope(const ResetPasswordPage())),
      );
      expect(find.text('パスワードを忘れた場合'), findsOneWidget);
      expect(find.text('メールアドレス'), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is MyTextFormField), findsOneWidget);
      expect(find.text('パスワードをリセットする'), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is PrimaryButton), findsOneWidget);
      expect(find.text('サインインページに戻る'), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is SecondaryButton), findsOneWidget);
    });

    group('パスワードのリセット', () {
      final resetUserPasswordUseCase = MockResetUserPasswordUsecase();

      testWidgets('リセットに成功する場合', (widgetTester) async {
        // given
        when(resetUserPasswordUseCase.execute(email: 'test@example.com'))
            .thenAnswer((_) => Future.value(true));
        await widgetTester.pumpWidget(
          ProviderScope(
            child: wrapMaterialApp(
              mockedProviderScope(
                const ResetPasswordPage(),
                overrides: [
                  resetUserPasswordUsecaseProvider.overrideWithValue(resetUserPasswordUseCase)
                ],
              ),
            ),
          ),
        );

        // when
        await widgetTester.enterText(
          find.byWidgetPredicate((widget) => widget is MyTextFormField),
          'test@example.com',
        );
        await widgetTester.tap(find.byWidgetPredicate((widget) => widget is PrimaryButton));
        await widgetTester.pumpAndSettle();

        // then
        expect(find.byWidgetPredicate((widget) => widget is AlertDialog), findsOneWidget);
        expect(find.text('パスワードのリセットに成功しました'), findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is TextButton), findsOneWidget);
        expect(find.text('サインイン画面に戻る'), findsOneWidget);
      });

      testWidgets('リセットに失敗する場合', (widgetTester) async {
        // given
        when(resetUserPasswordUseCase.execute(email: anyNamed('email')))
            .thenAnswer((_) => Future.value(false));
        await widgetTester.pumpWidget(
          ProviderScope(
            child: wrapMaterialApp(
              mockedProviderScope(
                const ResetPasswordPage(),
                overrides: [
                  resetUserPasswordUsecaseProvider.overrideWithValue(resetUserPasswordUseCase)
                ],
              ),
            ),
          ),
        );

        // when
        await widgetTester.enterText(
          find.byWidgetPredicate((widget) => widget is MyTextFormField),
          'test@example.co',
        );
        await widgetTester.tap(find.byWidgetPredicate((widget) => widget is PrimaryButton));
        await widgetTester.pumpAndSettle();

        // then
        expect(find.byWidgetPredicate((widget) => widget is AlertDialog), findsOneWidget);
        expect(find.text('パスワードのリセットに失敗しました'), findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is TextButton), findsOneWidget);
        expect(find.text('閉じる'), findsOneWidget);
      });
    });
  });
}

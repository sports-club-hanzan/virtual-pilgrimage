import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';

void main() {
  group('FormModel', () {
    test('onChangeText', () {
      // given
      final target = FormModel.of((value) => null);

      // when, then
      expect(target.onChangeText(), target);
    });

    test('onFocusChange', () {
      // given
      final target = FormModel.of((value) => null);
      final expected = target.copyWith(hasEdited: true, externalErrors: []);

      // when
      final actual = target.onFocusChange();

      // then
      expect(actual, expected);
    });

    group('displayError', () {
      test('focusが当たっていない場合', () {
        // given
        final target = FormModel.of((value) => null);

        // when
        final actual = target.displayError;

        // then
        expect(actual, null);
      });

      test('エラーが存在しない場合', () {
        // given
        final target = FormModel.of((value) => null).onFocusChange()
          ..focusNode.requestFocus();

        // when
        final actual = target.displayError;

        // then
        expect(actual, null);
      });

      test('エラーが存在する場合', () {
        // given
        final target = FormModel.of((value) => null)
            .addExternalError('dummy')
            .addExternalError('error')
            .onSubmit()
          ..focusNode.requestFocus();

        // when
        final actual = target.displayError;

        // then
        expect(actual, 'dummy\nerror');
      });

      test('バリデーションエラーが存在する場合', () {
        // given
        final target = FormModel.of(emailValidator)
            .addExternalError('dummy')
            .addExternalError('error')
            .onSubmit()
          ..focusNode.requestFocus();

        // when
        final actual = target.displayError;

        // then
        expect(actual, 'dummy\nerror\n必須項目です');
      });
    });

    test('addExternalError', () {
      // given, when
      final target = FormModel.of((value) => null)
          .addExternalError('dummy')
          .addExternalError('error');

      // then
      expect(target.externalErrors, ['dummy', 'error']);
    });

    group('バリデーション', () {
      group('email', () {
        final target = FormModel.of(emailValidator);
        final params = {
          '必須項目です': '',
          '不正な形式です': 'dummy',
        };
        for (final param in params.entries) {
          test(param.key, () {
            // given
            target.controller.text = param.value;

            // when
            final actualTarget = target.onSubmit()..focusNode.requestFocus();
            final actual = actualTarget.displayError;

            // then
            expect(actual, param.key);
          });

          test('関数自体のテスト: ${param.key}', () {
            // when, given
            final actual = emailValidator(param.value);

            // then
            expect(actual, param.key);
          });
        }
      });

      group('password', () {
        final target = FormModel.of(passwordValidator);
        final params = {
          '必須項目です': '',
          '半角英数字8文字以上で入力してください': 'pass123',
        };
        for (final param in params.entries) {
          test(param.key, () {
            // given
            target.controller.text = param.value;

            // when
            final actualTarget = target.onSubmit()..focusNode.requestFocus();
            final actual = actualTarget.displayError;

            // then
            expect(actual, param.key);
          });

          test('関数自体のテスト: ${param.key}', () {
            // when, given
            final actual = passwordValidator(param.value);

            // then
            expect(actual, param.key);
          });
        }
      });

      group('nickname', () {
        final target = FormModel.of(nicknameValidator);
        final params = {
          '必須項目です': '',
          '半角英数字6文字以上16文字以下で入力してください': 'n12i',
        };
        for (final param in params.entries) {
          test(param.key, () {
            // given
            target.controller.text = param.value;

            // when
            final actualTarget = target.onSubmit()..focusNode.requestFocus();
            final actual = actualTarget.displayError;

            // then
            expect(actual, param.key);
          });

          test('関数自体のテスト: ${param.key}', () {
            // when, given
            final actual = nicknameValidator(param.value);

            // then
            expect(actual, param.key);
          });
        }
      });
    });
  });
}

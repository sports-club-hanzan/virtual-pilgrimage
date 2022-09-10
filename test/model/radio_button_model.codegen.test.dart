import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/model/radio_button_model.codegen.dart';

void main() {
  group('RadioButtonModel', () {
    group('of', () {
      test('正常系', () {
        // given
        final titles = ['red', 'blue', 'yellow'];
        final values = [1, 2, 3];
        final expected = RadioButtonModel(
          focusNodes: [
            FocusNode(),
            FocusNode(),
            FocusNode(),
          ],
          titles: titles,
          values: values,
          selectedValue: 1,
        );

        // when
        final actual = RadioButtonModel.of(titles, values);

        // then
        expect(actual.titles, expected.titles);
        expect(actual.values, expected.values);
        expect(actual.selectedValue, 1);
      });

      test('異常系: titlesとvaluesの長さが違う', () {
        // given
        final titles = ['red', 'blue', 'yellow', 'green'];
        final values = [1, 2, 3];

        // when, then
        expect(
          () => RadioButtonModel.of(titles, values),
          throwsArgumentError,
        );
      });
    });
  });
}

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_model.codegen.freezed.dart';

typedef Validator = String? Function(String value);

final emailExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");

final passwordExp = RegExp(r"^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])[a-zA-Z\d]{8,}$");

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '必須項目です';
  } else if (!emailExp.hasMatch(value)) {
    return '不正な形式です';
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '必須項目です';
  } else if (!passwordExp.hasMatch(value)) {
    return '半角英数字(大文字小文字)8文字以上で入力してください';
  } else {
    return null;
  }
}

// 入力フォームで利用するモデル
// ref. https://github.com/torikatsupg/flutter_todo/blob/main/lib/model/form_model.dart
@freezed
class FormModel with _$FormModel {
  FormModel._();

  factory FormModel({
    required Validator validator,
    required TextEditingController controller,
    required FocusNode focusNode,
    @Default(false) bool hasEdited,
  }) = _FormModel;

  FormModel onChangeText() => this;

  FormModel onFocusChange() => copyWith(hasEdited: true);

  FormModel onSubmit() {
    unfocus();
    return copyWith(hasEdited: true);
  }

  void unfocus() => focusNode.unfocus();

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }

  String? get errors {
    return validator(controller.text);
  }

  bool isValid() => errors == null;

  static FormModel of(Validator validator, [String defaultText = '']) =>
      FormModel(
        validator: validator,
        controller: TextEditingController(text: defaultText),
        focusNode: FocusNode(),
      );
}

final form = FormModel.of(emailValidator);

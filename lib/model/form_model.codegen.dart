import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_model.codegen.freezed.dart';

typedef Validator = String? Function(String value);

final emailExp = RegExp(
  r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
);

final passwordExp = RegExp(r'^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z\d]{8,32}$');

final nicknameExp = RegExp(r'^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z\d]{6,16}$');

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
    return '半角英数字8文字以上で入力してください';
  } else {
    return null;
  }
}

String? nicknameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '必須項目です';
  } else if (!nicknameExp.hasMatch(value)) {
    return '半角英数字6文字以上16文字以下で入力してください';
  } else {
    return null;
  }
}

// 入力フォームで利用するモデル
// ref. https://github.com/torikatsupg/flutter_todo/blob/main/lib/model/form_model.dart
@freezed
class FormModel with _$FormModel {
  factory FormModel({
    required Validator validator,
    required TextEditingController controller,
    required FocusNode focusNode,
    @Default(false) bool hasEdited,
    @Default([]) List<String> externalErrors,
  }) = _FormModel;

  FormModel._();

  FormModel onChangeText() => this;

  FormModel onFocusChange() => copyWith(hasEdited: true, externalErrors: []);

  FormModel onSubmit() {
    unfocus();
    return copyWith(hasEdited: true);
  }

  void unfocus() => focusNode.unfocus();

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }

  late final isValid = _errors.isEmpty;
  late final text = controller.text;
  late final bool isDisplayedError = !focusNode.hasFocus && hasEdited;

  String? get displayError {
    if (!isDisplayedError) {
      return null;
    } else if (_errors.isEmpty) {
      return null;
    }
    return _errors.join('\n');
  }

  List<String> get _errors {
    final validationError = validator(controller.text);
    return [
      ...externalErrors,
      if (validationError != null) validationError,
    ];
  }

  FormModel addExternalError(String errorString) =>
      copyWith(externalErrors: [...externalErrors, errorString]);

  // ignore: prefer_constructors_over_static_methods
  static FormModel of(Validator validator, [String defaultText = '']) =>
      FormModel(
        validator: validator,
        controller: TextEditingController(text: defaultText),
        focusNode: FocusNode(),
      );
}

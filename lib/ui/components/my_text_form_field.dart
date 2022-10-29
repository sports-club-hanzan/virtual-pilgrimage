import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtualpilgrimage/model/form_model.codegen.dart';

class MyTextFormField extends StatefulWidget {
  MyTextFormField({
    super.key,
    required this.formModel,
    required this.onChanged,
    this.decoration = const InputDecoration(),
    this.obscureText = false,
    this.formatters,
    this.inputAction = TextInputAction.next,
    this.style,
    this.textInputType,
  })  : textEditingController = formModel.controller,
        focusNode = formModel.focusNode;

  // フォームのstateに関する変数
  final FormModel formModel;
  final ValueChanged<FormModel> onChanged;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final List<TextInputFormatter>? formatters;
  final TextInputAction inputAction;

  // デザインに関する変数
  // 必要に応じて追加
  // 以下が参考になる
  // ref. https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/text_form_field.dart
  final InputDecoration decoration;
  final TextStyle? style;
  final bool obscureText;
  final TextInputType? textInputType;

  @override
  State<StatefulWidget> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  void initState() {
    super.initState();

    widget.formModel.controller
        .addListener(() => widget.onChanged(widget.formModel.onChangeText()));
    widget.formModel.focusNode
        .addListener(() => widget.onChanged(widget.formModel.onFocusChange()));
  }

  @override
  void dispose() {
    super.dispose();
    widget.formModel.controller.removeListener(() {});
    widget.formModel.focusNode.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      decoration: widget.decoration.copyWith(
        errorText: widget.formModel.displayError,
        // 長いエラーにも対応
        errorMaxLines: 2,
      ),
      style: widget.style,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      inputFormatters: widget.formatters,
      textInputAction: widget.inputAction,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
    );
  }
}

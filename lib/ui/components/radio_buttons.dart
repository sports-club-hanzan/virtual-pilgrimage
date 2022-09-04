import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/model/radio_button_model.codegen.dart';

// ラジオボタンの定義に利用
// MEMO: generics を State に渡しても build に型をうまく渡せないので、継承して利用
abstract class RadioButtons<T> extends StatefulWidget {
  // フォームのstateに関する変数
  final RadioButtonModel<T> radioButtonModel;
  final void Function(T?) onChanged;
  final T groupValue;
  final List<FocusNode> focusNodes;

  RadioButtons({
    Key? key,
    required this.radioButtonModel,
    required this.onChanged,
    required this.groupValue,
  })  : focusNodes = radioButtonModel.focusNodes,
        super(key: key);
}

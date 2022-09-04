import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/radio_buttons.dart';

// ラジオボタンの定義に利用
class GenderRadioButtons extends RadioButtons<Gender> {
  GenderRadioButtons(
      {Key? key,
      required super.radioButtonModel,
      required super.onChanged,
      required super.groupValue})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenderRadioButtonsState<Gender>();
}

class _GenderRadioButtonsState<T> extends State<GenderRadioButtons> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.radioButtonModel.focusNodes.map((e) => e.removeListener(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.radioButtonModel.titles.length,
      itemBuilder: (BuildContext context, int index) {
        return RadioListTile<Gender>(
          value: widget.radioButtonModel.values[index],
          title: Text(widget.radioButtonModel.titles[index]),
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
          activeColor: Theme.of(context).primaryColor,
          focusNode: widget.focusNodes[index],
        );
      },
    );
  }
}

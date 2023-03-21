import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/radio_buttons.dart';
import 'package:virtualpilgrimage/ui/style/color.dart';

// ラジオボタンの定義に利用
class GenderRadioButtons extends RadioButtons<Gender> {
  GenderRadioButtons({
    super.key,
    required super.radioButtonModel,
    required super.onChanged,
    required super.groupValue,
  });

  @override
  State<StatefulWidget> createState() => _GenderRadioButtonsState<Gender>();
}

class _GenderRadioButtonsState<T> extends State<GenderRadioButtons> {
  final borderRadiusCircular = 24.0;

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
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: widget.radioButtonModel.values.length,
      // スペースのpx
      crossAxisSpacing: 16,
      childAspectRatio: 1.05,
      children: List.generate(
        widget.radioButtonModel.values.length,
        (index) {
          final isSelected =
              widget.radioButtonModel.selectedValue == widget.radioButtonModel.values[index];
          Color selectedColor = Theme.of(context).colorScheme.secondary;
          Color unselectedColor = Theme.of(context).colorScheme.secondaryContainer;
          if (widget.radioButtonModel.titles[index] == '男性') {
            selectedColor = Theme.of(context).colorScheme.primary;
            unselectedColor = Theme.of(context).colorScheme.primaryContainer;
          } else if (widget.radioButtonModel.titles[index] == '女性') {
            selectedColor = Theme.of(context).colorScheme.error;
            unselectedColor = Theme.of(context).colorScheme.tertiaryContainer;
          }

          return InkWell(
            borderRadius: BorderRadius.circular(borderRadiusCircular),
            onTap: () => widget.onChanged(widget.radioButtonModel.values[index]),
            child: Ink(
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : unselectedColor,
                borderRadius: BorderRadius.circular(borderRadiusCircular),
                border: Border.all(
                  color: isSelected ? Colors.redAccent : Colors.black12,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                child: Text(
                  widget.radioButtonModel.titles[index],
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                    fontSize: 20,
                    color: isSelected ? ColorStyle.text : ColorStyle.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

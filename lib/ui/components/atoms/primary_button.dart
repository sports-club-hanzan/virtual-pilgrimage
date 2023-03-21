import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

// 主要なアクションの実行のために指定するボタン
// Material3 の Filled Button に該当: https://m3.material.io/components/buttons/overview
// ref. https://api.flutter.dev/flutter/material/ButtonStyle-class.html
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.text,
    this.textSize = FontSize.mediumSize,
    this.buttonSize,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;
  final double textSize;
  final Size? buttonSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize?.width,
      height: buttonSize?.height,
      child: FilledButton(
        onPressed: onPressed,
        child: Semantics(
          label: text,
          child: Text(text, style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}

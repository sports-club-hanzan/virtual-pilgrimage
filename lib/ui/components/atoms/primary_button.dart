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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        minimumSize: const Size(48, 48),
        fixedSize: buttonSize,
        maximumSize: Size(MediaQuery.of(context).size.width - 24, 96),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
      onPressed: onPressed,
      // TODO(s14t284): custom font を導入 ref. https://zenn.dev/susatthi/articles/20220419-143426-flutter-custom-fonts
      child: Text(text, style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w500)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

// 補助的なアクションの実行のために指定するボタン
// Material3 の Filled Tonal Button に該当: https://m3.material.io/components/buttons/overview
// ref. https://api.flutter.dev/flutter/material/ButtonStyle-class.html
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
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
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        minimumSize: const Size(48, 48),
        fixedSize: buttonSize,
        maximumSize: Size(MediaQuery.of(context).size.width - 24, 96),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
      onPressed: onPressed,
      // TODO(s14t284): custom font を導入 ref. https://zenn.dev/susatthi/articles/20220419-143426-flutter-custom-fonts
      child: Text(text, style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w300)),
    );
  }
}

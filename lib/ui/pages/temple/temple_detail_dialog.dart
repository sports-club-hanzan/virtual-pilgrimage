import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/ui/components/atoms/primary_button.dart';

class TempleDetailDialog extends StatelessWidget {
  const TempleDetailDialog({
    required this.templeInfo,
    super.key,
  });

  final TempleInfo templeInfo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: SizedBox(
          // SizedBox + double.maxFinite がないと RenderViewport に関するエラーが発生する
          width: double.maxFinite,
          child: ListView(
            children: [
              Center(
                child: Image.network(templeInfo.images[0]),
              ),
              Text(templeInfo.knowledge),
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: PrimaryButton(
            onPressed: () => Navigator.pop(context, '閉じる'),
            text: '閉じる',
          ),
        )
      ],
    );
  }
}

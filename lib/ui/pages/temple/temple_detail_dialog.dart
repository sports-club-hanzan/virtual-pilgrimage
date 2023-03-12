import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/ui/components/atoms/primary_button.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class TempleDetailDialog extends StatelessWidget {
  const TempleDetailDialog({
    required this.templeInfo,
    super.key,
  });

  final TempleInfo templeInfo;

  @override
  Widget build(BuildContext context) {
    // 画像が表示できない時にエラーとならないよう適当な画像を表示できるようにしておく
    final templeImagePath = templeInfo.images.isNotEmpty
        ? templeInfo.images[0]
        : 'https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-dev.appspot.com/o/temples%2F1%2F1.jpeg?alt=media&token=b3fe42f9-b94b-43f2-8a5d-b2f217be541f';

    return AlertDialog(
      content: SizedBox(
        // SizedBox + double.maxFinite がないと RenderViewport に関するエラーが発生する
        width: double.maxFinite,
        height: 400,
        child: ListView(
          children: [
            Center(
              child: Text(
                '${templeInfo.id}番札所: ${templeInfo.name}',
                style: const TextStyle(
                  fontSize: FontSize.mediumLargeSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(templeInfo.knowledge),
            const SizedBox(height: 16),
            Center(child: Image.network(templeImagePath)),
            const SizedBox(height: 16),
            Center(
              child: Image(
                height: 300,
                image: NetworkImage(templeInfo.stampImage),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: PrimaryButton(
            buttonSize: Size(MediaQuery.of(context).size.width / 5 * 3, 48),
            onPressed: () => Navigator.pop(context, '閉じる'),
            text: '閉じる',
          ),
        )
      ],
    );
  }
}

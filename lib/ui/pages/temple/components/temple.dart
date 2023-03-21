
import 'package:flutter/material.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/temple/components/temple_detail_dialog.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';
import 'package:virtualpilgrimage/ui/wording_helper.dart';

// ref. https://developers.cyberagent.co.jp/blog/archives/39251/
class Temple extends StatefulWidget {
  const Temple({super.key, required this.templeInfo, this.user});

  final TempleInfo templeInfo;
  final VirtualPilgrimageUser? user;

  @override
  State<StatefulWidget> createState() => _Temple();
}

class _Temple extends State<Temple> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ユーザ情報を取得できなかった時のために、念の為デフォルト値を詰めておく
    final nowPilgrimageId = widget.user?.pilgrimage.nowPilgrimageId ?? 1;
    final lap = widget.user?.pilgrimage.lap ?? 1;
    final isShowDetail = nowPilgrimageId >= widget.templeInfo.id || 1 < lap;
    // 画像が表示できない時にエラーとならないよう適当な画像を表示できるようにしておく
    final imagePath = widget.templeInfo.images.isNotEmpty
        ? widget.templeInfo.images[0]
        : 'https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-dev.appspot.com/o/temples%2F1%2F1.jpeg?alt=media&token=b3fe42f9-b94b-43f2-8a5d-b2f217be541f';

    return Card(
      key: Key('temple_${widget.templeInfo.id}'),
      elevation: 0,
      margin: const EdgeInsets.all(4),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: 4),
        enabled: isShowDetail,
        leading: Image(
          width: 100,
          image: NetworkImage(imagePath),
          fit: BoxFit.fitHeight,
          color: isShowDetail ? null : Colors.black45,
          colorBlendMode: isShowDetail ? null : BlendMode.xor,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.templeInfo.id}番札所',
              style: const TextStyle(
                color: Colors.black38,
                fontSize: FontSize.mediumSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.templeInfo.name,
              style: TextStyle(
                color: isShowDetail
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primaryContainer,
                fontSize: FontSize.mediumLargeSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${widget.templeInfo.prefecture}・次の札所まで${WordingHelper.meterToKilometerString(widget.templeInfo.distance)}km',
              style: const TextStyle(color: Colors.black38, fontSize: FontSize.mediumSize),
            ),
          ],
        ),
        onTap: () => {
          if (isShowDetail)
            {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return TempleDetailDialog(templeInfo: widget.templeInfo);
                },
              )
            }
        },
      ),
    );
  }
}

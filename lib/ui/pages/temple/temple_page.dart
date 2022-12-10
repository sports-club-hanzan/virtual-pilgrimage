import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/temple/temple_detail_dialog.dart';
import 'package:virtualpilgrimage/ui/pages/temple/temple_presenter.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class TemplePage extends ConsumerWidget {
  const TemplePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: _TemplePageBody(ref: ref),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class _TemplePageBody extends StatelessWidget {
  const _TemplePageBody({
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(templeProvider).temples;
    final scrollController = ref.read(templeProvider).scrollController;
    final user = ref.watch(userStateProvider);

    return ListView.builder(
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return _buildTemple(context, state[index], user);
      },
      itemCount: state.length,
    );
  }

  Widget _buildTemple(BuildContext context, TempleInfo templeInfo, VirtualPilgrimageUser? user) {
    // ユーザ情報を取得できなかった時のために、念の為デフォルト値を詰めておく
    final nowPilgrimageId = user?.pilgrimage.nowPilgrimageId ?? 1;
    final lap = user?.pilgrimage.lap ?? 1;
    final isShowDetail = nowPilgrimageId >= templeInfo.id || 1 < lap;
    // 画像が表示できない時にエラーとならないよう適当な画像を表示できるようにしておく
    final imagePath = templeInfo.images.isNotEmpty
        ? templeInfo.images[0]
        : 'https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-dev.appspot.com/o/temples%2F1%2F1.jpeg?alt=media&token=b3fe42f9-b94b-43f2-8a5d-b2f217be541f';

    return Card(
      key: Key('temple_${templeInfo.id}'),
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: isShowDetail
            ? Image(width: 100, height: 80, image: NetworkImage(imagePath))
            : Image(
                width: 100,
                height: 80,
                image: NetworkImage(imagePath),
                color: Colors.black45,
                colorBlendMode: BlendMode.xor,
              ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${templeInfo.id}番札所',
              style: const TextStyle(
                color: Colors.black38,
                fontSize: FontSize.smallSize,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              templeInfo.name,
              style: const TextStyle(
                color: Color(0xff7b61ff),
                fontSize: FontSize.mediumSize,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        subtitle: Text(
          '${templeInfo.prefecture}・${templeInfo.distance}m',
          style: const TextStyle(color: Colors.black38, fontSize: FontSize.smallSize),
        ),
        onTap: () => {
          if (isShowDetail)
            {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return TempleDetailDialog(templeInfo: templeInfo);
                },
              )
            }
        },
      ),
    );
  }
}

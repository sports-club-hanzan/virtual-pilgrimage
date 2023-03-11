import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/components/bottom_navigation.dart';
import 'package:virtualpilgrimage/ui/components/my_app_bar.dart';
import 'package:virtualpilgrimage/ui/pages/temple/temple_detail_dialog.dart';
import 'package:virtualpilgrimage/ui/pages/temple/temple_presenter.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';
import 'package:virtualpilgrimage/ui/wording_helper.dart';

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
    final isLoading = ref.watch(templeProvider).loading;
    final user = ref.watch(userStateProvider);

    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Opacity(
              // 読み込み中は背景を透過させてローディングを目立たせる
              opacity: isLoading ? 0.25 : 1,
              child: SizedBox(
                height: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildTemple(context, state[index], user);
                  },
                  itemCount: state.length,
                ),
              ),
            ),
            if (isLoading)
              Center(
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: CircularProgressIndicator(
                    strokeWidth: 16,
                    color: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
          ],
        ),
      ),
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
              '${templeInfo.id}番札所',
              style: const TextStyle(
                color: Colors.black38,
                fontSize: FontSize.mediumSize,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              templeInfo.name,
              style: TextStyle(
                color: isShowDetail
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primaryContainer,
                fontSize: FontSize.mediumLargeSize,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${templeInfo.prefecture}・次の札所まで${WordingHelper.meterToKilometerString(templeInfo.distance)}km',
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
                  return TempleDetailDialog(templeInfo: templeInfo);
                },
              )
            }
        },
      ),
    );
  }
}

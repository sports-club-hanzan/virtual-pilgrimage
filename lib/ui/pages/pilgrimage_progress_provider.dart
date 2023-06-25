import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/ui/components/molecules/pilgrimage_progress_card.dart';

Widget pilgrimageProgressCardProvider(
  BuildContext context,
  VirtualPilgrimageUser? user,
  WidgetRef ref,
) {
  if (user == null) {
    return Container();
  }
  const maxTempleNumber = 88;
  final templeRepository = ref.read(templeRepositoryProvider);

  /// 次の札所の番号を返す
  /// 88箇所目に到達していたら 1 を返す
  /// [pilgrimageId] 現在の札所の番号
  int nextPilgrimageNumber(int pilgrimageId) {
    if (pilgrimageId < maxTempleNumber) {
      return pilgrimageId + 1;
    }
    return 1;
  }

  return FutureBuilder<List<TempleInfo>>(
    // 次の札所への距離は到達している札所が持っているデータ構造となっているため、2つ取得する必要がある
    // 実態はキャッシュしてあるmapからデータを引っ張ってきているだけ
    future: () async {
      // ユーザの現在到達している地点のお寺の情報
      final now = await templeRepository.getTempleInfo(user.pilgrimage.nowPilgrimageId);
      // ユーザが向かっているのお寺の情報
      final next = await templeRepository
          .getTempleInfo(nextPilgrimageNumber(user.pilgrimage.nowPilgrimageId));
      return [now, next];
    }(),
    builder: (BuildContext context, AsyncSnapshot<List<TempleInfo>> snapshot) {
      // loading中のwidget
      Widget childWidget = const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SizedBox(height: 50, width: 50, child: CircularProgressIndicator())],
      );

      if (snapshot.hasData) {
        final data = snapshot.requireData;
        childWidget = PilgrimageProgressCard(
          pilgrimageInfo: user.pilgrimage,
          templeInfo: data[1],
          nextDistance: data[0].distance,
        );
      } else if (snapshot.hasError) {
        ref.read(firebaseCrashlyticsProvider).recordError(snapshot.error, null);
        // TODO(s14t284): 取得できなかった場合のUIを改善する
        childWidget = const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('お遍路の進捗状況が取得できませんでした', style: TextStyle(fontWeight: FontWeight.bold))
          ],
        );
      }
      return SizedBox(
        height: 140,
        width: MediaQuery.of(context).size.width / 10 * 9.5,
        child: childWidget,
      );
    },
  );
}

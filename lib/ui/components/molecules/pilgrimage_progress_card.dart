import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';
import 'package:virtualpilgrimage/ui/wording_helper.dart';

Widget pilgrimageProgressCardProvider(
  BuildContext context,
  WidgetRef ref,
) {
  const maxTempleNumber = 88;
  final templeRepository = ref.read(templeRepositoryProvider);
  final user = ref.watch(userStateProvider);
  if (user == null) {
    return Container();
  }

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
      Widget childWidget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [SizedBox(height: 50, width: 50, child: CircularProgressIndicator())],
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
        childWidget = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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

class PilgrimageProgressCard extends StatelessWidget {
  const PilgrimageProgressCard({
    super.key,
    required this.pilgrimageInfo,
    required this.templeInfo,
    required this.nextDistance,
  });

  final PilgrimageInfo pilgrimageInfo;
  final TempleInfo templeInfo;
  final int nextDistance;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Colors.transparent,
          width: 0.5,
        ),
      ),
      color: Theme.of(context).colorScheme.onSecondary,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              '次は',
              style: TextStyle(fontSize: FontSize.largeSize, fontWeight: FontWeight.bold),
            ),
            // n札所・〇〇寺
            _nextTempleInfo(context),
            // 進捗率の表示
            progressCircularPercentIndicator(context)
          ],
        ),
      ),
    );
  }

  Column _nextTempleInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${templeInfo.id}番札所',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            fontSize: FontSize.mediumSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          WordingHelper.templeNameFilter(templeInfo.name),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: FontSize.xlargeSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  CircularPercentIndicator progressCircularPercentIndicator(BuildContext context) {
    // 移動距離 > 目標距離とならないよう念の為制御
    final movingDistance =
        pilgrimageInfo.movingDistance < nextDistance ? pilgrimageInfo.movingDistance : nextDistance;
    return CircularPercentIndicator(
      radius: 60,
      lineWidth: 16,
      percent: _calcPercent(pilgrimageInfo.movingDistance, nextDistance),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      progressColor: Theme.of(context).colorScheme.primary,
      animation: true,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _meterToKilometerString(movingDistance),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontSize: FontSize.mediumSize + 2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(' km', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            height: 2,
            indent: 25,
            endIndent: 25,
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _meterToKilometerString(nextDistance),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontSize: FontSize.mediumSize + 2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(' km', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  /// m単位の数値をkm単位に補正した文字列を返す
  /// お遍路の進捗は小数点第一位までで表示する
  ///
  /// [meter] m単位の数値
  String _meterToKilometerString(int meter) => (meter / 1000).toStringAsFixed(1);

  /// 次の札所までの進捗率を計算
  double _calcPercent(int movingDistance, int nextTempleDistance) {
    var percent = movingDistance / nextTempleDistance;
    if (percent > 1) {
      percent = 1;
    }
    return percent;
  }
}

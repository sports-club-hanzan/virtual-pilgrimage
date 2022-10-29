import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/domain/user/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

Widget pilgrimageProgressCardProvider(
  BuildContext context,
  VirtualPilgrimageUser user,
  WidgetRef ref,
) {
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
      if (snapshot.hasData) {
        final data = snapshot.requireData;
        return SizedBox(
          height: 170,
          width: MediaQuery.of(context).size.width / 10 * 9,
          child: PilgrimageProgressCard(
            pilgrimageInfo: user.pilgrimage,
            templeInfo: data[1],
            nextDistance: data[0].distance,
          ),
        );
      }
      // TODO(s14t284): 取得できなかった場合のUIを改善する
      return const Text('お遍路の進捗状況が取得できませんでした');
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
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Colors.transparent,
          width: 0.5,
        ),
      ),
      color: Theme.of(context).colorScheme.onSecondary,
      child: Padding(
        padding: const EdgeInsets.all(8),
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
          _templeNameFilter(templeInfo.name),
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
      radius: 64,
      lineWidth: 18,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      progressColor: Theme.of(context).colorScheme.primary,
      percent: _calcPercent(pilgrimageInfo.movingDistance, nextDistance),
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
                  fontSize: FontSize.largeSize - 4,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(' km', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            height: 3,
            indent: 30,
            endIndent: 30,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _meterToKilometerString(nextDistance),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontSize: FontSize.largeSize - 4,
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
  ///
  /// [meter] m単位の数値
  String _meterToKilometerString(int meter) {
    return (meter / 1000).toStringAsFixed(1);
  }

  /// 次の札所までの進捗率を計算
  double _calcPercent(int movingDistance, int nextTempleDistance) {
    var percent = movingDistance / nextTempleDistance;
    if (percent > 1) {
      percent = 1;
    }
    return percent;
  }

  /// お寺の表示名をUIに合わせる
  /// （通称）のような名称をもつデータがあるため、このメソッドで通称を表示しないようにフィルタリング
  /// ex. 【24番札所】最御崎寺（東寺）
  String _templeNameFilter(String templeName) {
    if (templeName.contains('（')) {
      return templeName.replaceRange(templeName.indexOf('（'), templeName.length, '');
    }
    return templeName;
  }
}

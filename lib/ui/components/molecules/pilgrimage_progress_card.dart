import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';
import 'package:virtualpilgrimage/ui/wording_helper.dart';

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
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Colors.transparent,
          width: 0.5,
        ),
      ),
      color: Theme.of(context).colorScheme.surfaceVariant, // .onSecondary,
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

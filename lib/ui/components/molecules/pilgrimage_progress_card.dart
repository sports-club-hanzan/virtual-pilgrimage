import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/ui/style/font.dart';

class PilgrimageProgressCard extends StatelessWidget {
  const PilgrimageProgressCard({
    super.key,
    required this.pilgrimageInfo,
    required this.templeInfo,
  });

  final PilgrimageInfo pilgrimageInfo;
  final TempleInfo templeInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          width: 0.3,
        ),
        borderRadius: BorderRadius.circular(8),
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
          templeInfo.name,
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
    final movingDistance = pilgrimageInfo.movingDistance < templeInfo.distance
        ? pilgrimageInfo.movingDistance
        : templeInfo.distance;
    return CircularPercentIndicator(
      radius: 50,
      lineWidth: 15,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      progressColor: Theme.of(context).colorScheme.primary,
      percent: _calcPercent(pilgrimageInfo.movingDistance, templeInfo.distance),
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _meterToKilometerString(movingDistance),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: FontSize.mediumSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            height: 3,
            indent: 35,
            endIndent: 35,
            thickness: 1.5,
          ),
          Text(
            _meterToKilometerString(templeInfo.distance),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: FontSize.mediumSize,
              fontWeight: FontWeight.bold,
            ),
          )
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
}

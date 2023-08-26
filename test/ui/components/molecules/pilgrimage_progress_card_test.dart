import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/ui/components/molecules/pilgrimage_progress_card.dart';

import '../../../helper/wrap_material_app.dart';

void main() {
  tz.initializeTimeZones();

  group('PilgrimageProgressCardTest', () {
    const key = Key('key');
    const templeInfo = TempleInfo(
      id: 23,
      name: '薬王寺',
      prefecture: '徳島県',
      address: '徳島県海部郡日和佐町奥河内寺前２８５－１',
      distance: 75400,
      geoPoint: GeoPoint(33.73244444, 134.5274722),
      encodedPoints: '',
      stampImage: '1.png',
    );
    final pilgrimageInfo = PilgrimageInfo(
      id: 'dummy',
      updatedAt: CustomizableDateTime.current,
      movingDistance: 10000,
    );

    testWidgets('表示できる', (widgetTester) async {
      await widgetTester.pumpWidget(
        wrapMaterialApp(
          PilgrimageProgressCard(
            key: key,
            pilgrimageInfo: pilgrimageInfo,
            templeInfo: templeInfo,
            nextDistance: 10000,
          ),
        ),
      );
    });
  });
}

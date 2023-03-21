import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/temple/components/temple_detail_dialog.dart';

import '../../../helper/provider_container.dart';
import '../../../helper/wrap_material_app.dart';

void main() {
  final templeInfo = createTempleInfo(id: 1, name: '霊山寺');

  group('TempleDetailDialog', () {
    testWidgets('表示できる', (widgetTester) async {
      // MEMO: mockNetworkImagesFor: Network通信をmock化してテスト
      await mockNetworkImagesFor(
        () => widgetTester.pumpWidget(
          wrapMaterialApp(mockedProviderScope(TempleDetailDialog(templeInfo: templeInfo))),
        ),
      );
    });
  });
}

TempleInfo createTempleInfo({required int id, required String name, String prefecture = '徳島県'}) {
  return TempleInfo(
    id: id,
    name: name,
    prefecture: prefecture,
    address: '$prefecture**市++町',
    distance: 1400,
    encodedPoints: '',
    geoPoint: const GeoPoint(34, 134),
    stampImage: '1.png',
  );
}

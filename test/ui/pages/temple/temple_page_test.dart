import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/pilgrimage/temple_repository_impl.dart';
import 'package:virtualpilgrimage/ui/pages/temple/temple_page.dart';

import '../../../application/pilgrimage/update_pilgrimage_progress_interactor_test.mocks.dart';
import '../../../helper/provider_container.dart';
import '../../../helper/wrap_material_app.dart';

void main() {
  final templeRepository = MockTempleRepository();
  when(templeRepository.getTempleInfoAll()).thenAnswer((_) => Future.value());

  // ダイアログの表示テストはwidgetテストの範囲に収まらないので、実装していない
  group('TemplePage', () {
    testWidgets('表示できる', (widgetTester) async {
      // MEMO: mockNetworkImagesFor: Network通信をmock化してテスト
      await mockNetworkImagesFor(
        () => widgetTester.pumpWidget(
          wrapMaterialApp(
            mockedProviderScope(
              const TemplePage(),
              overrides: [
                templeRepositoryProvider.overrideWithValue(templeRepository),
                templeInfoCache.overrideWith((_) => createTempleInfoMap()),
              ],
            ),
          ),
        ),
      );
      expect(find.text('1番札所'), findsOneWidget);
      expect(find.text('霊山寺'), findsOneWidget);
      // スクロールしないと見えないはず
      expect(find.text('大窪寺'), findsNothing);
      // スクロールしないと6件までしか見えないはず
      expect(find.text('徳島県・1400m'), findsNWidgets(6));
    });

    testWidgets('スクロールすると次の札所情報が表示される', (widgetTester) async {
      await mockNetworkImagesFor(
        () => widgetTester.pumpWidget(
          wrapMaterialApp(
            mockedProviderScope(
              const TemplePage(),
              overrides: [
                templeRepositoryProvider.overrideWithValue(templeRepository),
                templeInfoCache.overrideWith((_) => createTempleInfoMap()),
              ],
            ),
          ),
        ),
      );

      // ref. https://docs.flutter.dev/cookbook/testing/widget/scrolling
      final listFinder = find.byType(Scrollable);
      final itemFinder = find.byKey(const ValueKey('temple_88'));

      await widgetTester.scrollUntilVisible(itemFinder, 500, scrollable: listFinder);

      // 末尾のお寺情報が見えているはず
      expect(itemFinder, findsOneWidget);
      // 期待する情報が見えているか検証
      expect(find.text('28番札所'), findsOneWidget);
      expect(find.text('41番札所'), findsOneWidget);
      expect(find.text('長尾寺'), findsOneWidget);
      expect(find.text('高知県・1400m'), findsOneWidget);
      expect(find.text('愛媛県・1400m'), findsOneWidget);
      expect(find.text('香川県・1400m'), findsNWidgets(2));
    });
  });
}

Map<int, TempleInfo> createTempleInfoMap() => {
      1: createTempleInfo(id: 1, name: '霊山寺'),
      2: createTempleInfo(id: 2, name: '極楽寺'),
      3: createTempleInfo(id: 3, name: '金泉寺'),
      4: createTempleInfo(id: 4, name: '大日寺'),
      5: createTempleInfo(id: 5, name: '地蔵寺'),
      6: createTempleInfo(id: 6, name: '安楽寺'),
      7: createTempleInfo(id: 7, name: '十楽寺'),
      28: createTempleInfo(id: 28, name: '大日寺', prefecture: '高知県'),
      41: createTempleInfo(id: 41, name: '龍光寺', prefecture: '愛媛県'),
      87: createTempleInfo(id: 87, name: '長尾寺', prefecture: '香川県'),
      88: createTempleInfo(id: 88, name: '大窪寺', prefecture: '香川県'),
    };

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

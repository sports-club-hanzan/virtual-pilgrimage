import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/ui/pages/home/home_presenter.dart';

import '../../../helper/fakes/fake_temple_repository.dart';
import '../../../helper/provider_container.dart';

void main() {
  late HomePresenter target;
  late TempleRepository templeRepository;
  late TempleInfo templeInfo;

  setUp(() {
    templeInfo = const TempleInfo(
      id: 23,
      name: '薬王寺',
      prefecture: '徳島県',
      address: '徳島県海部郡日和佐町奥河内寺前２８５－１',
      distance: 75400,
      geoPoint: GeoPoint(33.73244444, 134.5274722),
      encodedPoints: '',
    );
    templeRepository = FakeTempleRepository(templeInfo);
    final container = mockedProviderContainer(
      overrides: [templeRepositoryProvider.overrideWithValue(templeRepository)],
    );
    target = container.read(homeProvider.notifier);
  });

  group('HomePresenter', () {
    test('DI', () {
      expect(target, isNotNull);
    });

    // TODO(s14t284): UIやPresenterのテストを必要に応じて書く
  });
}

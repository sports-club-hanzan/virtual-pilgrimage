import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_provider.dart';

import '../../helper/mock.mocks.dart';
import '../../helper/provider_container.dart';

void main() {
  late MockFirebaseFirestore mockFirebaseFirestore;
  late TempleRepository target;

  late ProviderContainer container;
  late MockDocumentSnapshot<TempleInfo> mockDocumentSnapshot;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<TempleInfo> mockTempleInfoDocumentReference;
  late MockDocumentReference<Map<String, dynamic>> mockMapDocumentReference;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    // Reader をフィールドに持つのでProviderから取得したクラスを使ってテストする
    container = mockedProviderContainer(
      overrides: [firestoreProvider.overrideWithValue(mockFirebaseFirestore)],
    );
    target = container.read(templeRepositoryProvider);

    mockDocumentSnapshot = MockDocumentSnapshot();
    mockCollectionReference = MockCollectionReference();
    mockMapDocumentReference = MockDocumentReference();
    mockTempleInfoDocumentReference = MockDocumentReference();
  });

  group('TempleRepositoryImpl', () {
    test('DI', () {
      expect(target, isNotNull);
    });

    setUp(() {
      when(mockFirebaseFirestore.collection('temples')).thenReturn(mockCollectionReference);
      when(
        mockMapDocumentReference.withConverter<TempleInfo>(
          fromFirestore: anyNamed('fromFirestore'),
          toFirestore: anyNamed('toFirestore'),
        ),
      ).thenReturn(mockTempleInfoDocumentReference);
      when(mockTempleInfoDocumentReference.get(const GetOptions(source: Source.serverAndCache)))
          .thenAnswer(
        (_) => Future.value(mockDocumentSnapshot),
      );
    });

    group('get', () {
      const templeId = 1;
      final expected = defaultTempleInfo(templeId);
      setUp(() {
        when(mockDocumentSnapshot.data()).thenReturn(expected);
        when(mockCollectionReference.doc(templeId.toString())).thenReturn(mockMapDocumentReference);
        when(mockDocumentSnapshot.exists).thenReturn(true);
      });

      group('正常系', () {
        test('お寺情報が取得できる', () async {
          final actual = await target.getTempleInfo(1);
          expect(actual, expected);
          verify(mockFirebaseFirestore.collection('temples')).called(1);
        });
      });
    });
  });
}

TempleInfo defaultTempleInfo([
  int templeId = 1,
]) {
  return TempleInfo(
    id: templeId,
    address: '徳島県まるまる市',
    geoPoint: const GeoPoint(0, 2.11),
    name: 'お寺',
    prefecture: '徳島県',
    distance: 1000,
    encodedPoints:
        'mwnoEuc}sXJ?z@Z\\D?h@@|@TtBPx@rAtD\\pALh@X|B\\hDHtABf@Jf@Bh@HTBTRtBl@hFRdA\\lAHPx@vCl@xBx@vB^l@bAxAx@v@GHC|@?\\Cn@e@Ny@TOx@O?E@In@',
    stampImage: '1.png',
  );
}

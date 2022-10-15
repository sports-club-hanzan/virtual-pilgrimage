import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_provider.dart';
import 'package:virtualpilgrimage/infrastructure/temple/temple_repository_impl.dart';

import '../../helper/mock.mocks.dart';
import '../../helper/mock_query_document_snapshot.dart';
import '../../helper/provider_container.dart';

void main() {
  late MockFirebaseFirestore mockFirebaseFirestore;
  late TempleRepository target;

  late ProviderContainer container;
  late MockDocumentSnapshot<TempleInfo> mockDocumentSnapshot;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<TempleInfo> mockTempleInfoDocumentReference;
  late MockDocumentReference<Map<String, dynamic>> mockMapDocumentReference;
  late QueryDocumentSnapshot<Map<String, dynamic>> snapshot1;
  late QueryDocumentSnapshot<Map<String, dynamic>> snapshot2;

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
    snapshot1 = MockQueryDocumentSnapshot({}, mockMapDocumentReference);
    snapshot2 = MockQueryDocumentSnapshot({}, mockMapDocumentReference);
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
      when(mockTempleInfoDocumentReference.get()).thenAnswer(
        (_) => Future.value(mockDocumentSnapshot),
      );
    });

    group('get', () {
      const templeId = 1;
      final expected = defaultTempleInfo(templeId);
      setUp(() {
        when(mockDocumentSnapshot.data()).thenReturn(expected);
        when(mockCollectionReference.doc(templeId.toString())).thenReturn(mockMapDocumentReference);
      });

      group('正常系', () {
        test('お寺情報が取得できる', () async {
          final actual = await target.getTempleInfo(1);
          expect(actual, expected);
          verify(mockFirebaseFirestore.collection('temples')).called(1);
        });
        test('キャッシュからお寺の情報を取得できる', () async {
          // given
          container.read(templeInfoCache.state).state = {11: defaultTempleInfo(11)};

          // when
          final actual = await target.getTempleInfo(11);
          expect(actual, defaultTempleInfo(11));
          // Firestoreへの問い合わせを行なっていない
          verifyNever(mockFirebaseFirestore.collection('temples')).called(0);
        });
      });
    });

    group('getTempleInfoAll', () {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = MockQuerySnapshot();
      test('正常系', () async {
        // given
        when(mockCollectionReference.get()).thenAnswer((_) => Future.value(querySnapshot));
        when(querySnapshot.docs).thenReturn([snapshot1, snapshot2]);
        when(mockDocumentSnapshot.exists).thenReturn(true);
        when(mockDocumentSnapshot.data()).thenReturn(defaultTempleInfo());

        // when
        await target.getTempleInfoAll();

        // then
        expect(container.read(templeInfoCache), {1: defaultTempleInfo()});
        verify(mockFirebaseFirestore.collection('temples')).called(1);
        verify(querySnapshot.docs).called(1);
        verify(mockTempleInfoDocumentReference.get()).called(2);
        verify(mockDocumentSnapshot.exists).called(2);
        verify(mockDocumentSnapshot.data()).called(2);
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
  );
}

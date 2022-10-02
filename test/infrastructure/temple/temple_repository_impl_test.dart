import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/temple/temple_repository_impl.dart';

import '../../helper/mock.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirebaseFirestore;
  late TempleRepositoryImpl target;

  late MockDocumentSnapshot<TempleInfo> mockDocumentSnapshot;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<TempleInfo> mockTempleinfoDocumentReference;
  late MockDocumentReference<Map<String, dynamic>> mockMapDocumentReference;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    target = TempleRepositoryImpl(
      mockFirebaseFirestore,
    );

    mockDocumentSnapshot = MockDocumentSnapshot();
    mockCollectionReference = MockCollectionReference();
    mockMapDocumentReference = MockDocumentReference();
    mockTempleinfoDocumentReference = MockDocumentReference();
  });

  group('TempleRepositoryImpl', () {
    group('get', () {
      const templeId = 1;
      final expected = defaultTempleInfo(templeId);
      setUp(() {
        when(mockDocumentSnapshot.data()).thenReturn(expected);
        when(mockTempleinfoDocumentReference.get()).thenAnswer(
          (_) => Future.value(mockDocumentSnapshot),
        );
        when(
          mockMapDocumentReference.withConverter<TempleInfo>(
            fromFirestore: anyNamed('fromFirestore'),
            toFirestore: anyNamed('toFirestore'),
          ),
        ).thenReturn(mockTempleinfoDocumentReference);
        when(mockCollectionReference.doc(templeId.toString())).thenReturn(mockMapDocumentReference);
        when(mockFirebaseFirestore.collection('temples')).thenReturn(mockCollectionReference);
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
    nextDistance: 1,
  );
}

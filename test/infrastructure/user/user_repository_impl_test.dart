import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/user/user_repository_impl.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  FirebaseAuth,
  DocumentSnapshot,
  CollectionReference,
  DocumentReference
])
void main() {
  final logger = Logger();

  MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
  UserRepositoryImpl target = UserRepositoryImpl(mockFirebaseFirestore, logger);

  MockDocumentSnapshot<VirtualPilgrimageUser> mockDocumentSnapshot =
      MockDocumentSnapshot();
  MockCollectionReference<Map<String, dynamic>> mockCollectionReference =
      MockCollectionReference();
  MockDocumentReference<VirtualPilgrimageUser> mockDocumentReference =
      MockDocumentReference();

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    target = UserRepositoryImpl(
      mockFirebaseFirestore,
      logger,
    );

    mockDocumentSnapshot = MockDocumentSnapshot();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
  });

  group('get', () {
    const userId = 'dummy';
    test('正常系', () async {
      // given
      final expected = defaultUser(userId);
      defaultGetMock(
        mockFirebaseFirestore,
        mockDocumentSnapshot,
        mockCollectionReference,
        mockDocumentReference,
        expected,
      );

      // when
      final actual = await target.get(userId);

      // then
      expect(actual, expected);
    });
  });
}

void defaultGetMock(
  MockFirebaseFirestore mockFirebaseFirestore,
  MockDocumentSnapshot<VirtualPilgrimageUser> mockDocumentSnapshot,
  MockCollectionReference<Map<String, dynamic>> mockCollectionReference,
  MockDocumentReference<VirtualPilgrimageUser> mockDocumentReference,
  VirtualPilgrimageUser user,
) {
  // withConverter の mock のために利用
  final MockDocumentReference<Map<String, dynamic>>
      mockDocumentReferenceForConverter = MockDocumentReference();

  when(mockDocumentSnapshot.data()).thenReturn(user);
  when(mockDocumentSnapshot.exists).thenReturn(true);
  when(mockDocumentReference.get()).thenAnswer(
    (_) => Future.value(mockDocumentSnapshot),
  );
  when(
    mockDocumentReferenceForConverter.withConverter<VirtualPilgrimageUser>(
      fromFirestore: anyNamed('fromFirestore'),
      toFirestore: anyNamed('toFirestore'),
    ),
  ).thenReturn(mockDocumentReference);
  when(mockCollectionReference.doc(user.id))
      .thenReturn(mockDocumentReferenceForConverter);
  when(mockFirebaseFirestore.collection('users'))
      .thenReturn(mockCollectionReference);
}

VirtualPilgrimageUser defaultUser([String userId = 'dummyId']) {
  return VirtualPilgrimageUser(
    id: userId,
    nickname: 'dummyName',
    email: 'test@example.com',
    birthDay: DateTime.utc(2000),
    userStatus: UserStatus.created,
  );
}

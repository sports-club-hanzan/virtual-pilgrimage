import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/infrastructure/user/user_repository_impl.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  Logger,
  FirebaseAuth,
  DocumentSnapshot,
  CollectionReference,
  DocumentReference
])
void main() {
  MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
  MockLogger mockLogger = MockLogger();
  UserRepositoryImpl target;

  MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot =
      MockDocumentSnapshot();
  MockCollectionReference mockCollectionReference = MockCollectionReference();
  MockDocumentReference mockDocumentReference = MockDocumentReference();

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockLogger = MockLogger();
    target = UserRepositoryImpl(
      mockFirebaseFirestore,
      mockLogger,
    );

    mockDocumentSnapshot = MockDocumentSnapshot();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
  });

  group('get', () {
    const userId = 'dummy';
    test('正常系', () async {
      defaultMock(
        mockFirebaseFirestore,
        mockDocumentSnapshot,
        mockCollectionReference,
        mockDocumentReference,
        userId,
      );
    });
  });
}

void defaultMock(
  MockFirebaseFirestore mockFirebaseFirestore,
  MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot,
  MockCollectionReference mockCollectionReference,
  MockDocumentReference mockDocumentReference,
  String userId,
) {
  // TODO(s14t284): モックを整えてテストを書く
  when(mockFirebaseFirestore.collection(any).doc(any).get())
      .thenAnswer((_) => Future.value(mockDocumentSnapshot));
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/user/user_repository_impl.dart';

import '../../helper/mock_query_document_snapshot.dart';
import 'user_repository_impl_test.mocks.dart';

@GenerateMocks(
  [
    FirebaseFirestore,
    FirebaseAuth,
    DocumentSnapshot,
    CollectionReference,
    DocumentReference,
    Query,
    QuerySnapshot,
  ],
)
void main() {
  final logger = Logger(level: Level.error);

  MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
  UserRepositoryImpl target = UserRepositoryImpl(mockFirebaseFirestore, logger);

  MockDocumentSnapshot<VirtualPilgrimageUser> mockDocumentSnapshot =
      MockDocumentSnapshot();
  MockCollectionReference<Map<String, dynamic>> mockCollectionReference =
      MockCollectionReference();
  MockDocumentReference<VirtualPilgrimageUser> mockUserDocumentReference =
      MockDocumentReference();
  MockDocumentReference<Map<String, dynamic>> mockMapDocumentReference =
      MockDocumentReference();
  MockQuery<Map<String, dynamic>> mockQuery = MockQuery();
  MockQuery<VirtualPilgrimageUser> mockQueryDomainUser = MockQuery();
  MockQuerySnapshot<VirtualPilgrimageUser> mockQuerySnapshot =
      MockQuerySnapshot();

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    target = UserRepositoryImpl(
      mockFirebaseFirestore,
      logger,
    );

    mockDocumentSnapshot = MockDocumentSnapshot();
    mockCollectionReference = MockCollectionReference();
    mockUserDocumentReference = MockDocumentReference();
    mockMapDocumentReference = MockDocumentReference();
    mockQuery = MockQuery();
    mockQueryDomainUser = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
  });

  group('get', () {
    const userId = 'dummy';
    group('正常系', () {
      test('ユーザ情報が取得できる', () async {
        // given
        final expected = defaultUser(userId);
        defaultGetMock(
          mockFirebaseFirestore,
          mockDocumentSnapshot,
          mockCollectionReference,
          mockUserDocumentReference,
          mockMapDocumentReference,
          expected,
        );

        // when
        final actual = await target.get(userId);

        // then
        expect(actual, expected);
        verify(mockFirebaseFirestore.collection('users')).called(1);
      });

      test('指定したIDのユーザが存在しない', () async {
        // given
        defaultGetMock(
          mockFirebaseFirestore,
          mockDocumentSnapshot,
          mockCollectionReference,
          mockUserDocumentReference,
          mockMapDocumentReference,
          defaultUser(userId),
        );
        when(mockDocumentSnapshot.exists).thenReturn(false);

        // when
        final actual = await target.get(userId);

        // then
        expect(actual, null);
      });
    });

    group('異常系', () {
      final params = {
        'FirebaseException': FirebaseException(plugin: 'dummy'),
        'Exception': Exception(),
      };

      for (final param in params.entries) {
        test('${param.key} が発生', () async {
          // given
          when(mockFirebaseFirestore.collection('users'))
              .thenThrow(param.value);

          // when
          // repository 側で DatabaseException に変換していることを確認
          expect(
            () => target.get('dummyId'),
            throwsA(const TypeMatcher<DatabaseException>()),
          );
          verify(mockFirebaseFirestore.collection('users')).called(1);
        });
      }
    });
  });

  group('update', () {
    final user = defaultUser();
    group('正常系', () {
      test('ユーザ情報が更新・作成できる', () async {
        // given
        defaultUpdateMock(
          mockFirebaseFirestore,
          mockCollectionReference,
          mockMapDocumentReference,
          user,
        );

        // when
        await target.update(user);

        // then
        verify(mockFirebaseFirestore.collection('users')).called(1);
        verify(mockMapDocumentReference.set(user.toJson())).called(1);
      });
    });

    group('異常系', () {
      final params = {
        'FirebaseException': FirebaseException(plugin: 'dummy'),
        'Exception': Exception(),
      };

      for (final param in params.entries) {
        test('${param.key} が発生', () async {
          // given
          when(mockFirebaseFirestore.collection('users'))
              .thenThrow(param.value);

          // when
          // repository 側で DatabaseException に変換していることを確認
          expect(
            () => target.update(user),
            throwsA(const TypeMatcher<DatabaseException>()),
          );
          verify(mockFirebaseFirestore.collection('users')).called(1);
        });
      }
    });
  });

  group('findWithNickname', () {
    final users = [
      defaultUser('user1', 'name1'),
      defaultUser('user2', 'name2'),
    ];

    group('正常系', () {
      test('指定したニックネームのユーザが取得できる', () async {
        // given
        defaultFindWithNicknameMock(
          mockFirebaseFirestore,
          mockCollectionReference,
          mockQuery,
          mockQueryDomainUser,
          mockQuerySnapshot,
          users,
          'user1',
        );

        // when
        final actual = await target.findWithNickname('user1');

        // then
        expect(actual, users[0]);
      });
      test('指定したニックネームのユーザが存在しない', () async {
        // given
        defaultFindWithNicknameMock(
          mockFirebaseFirestore,
          mockCollectionReference,
          mockQuery,
          mockQueryDomainUser,
          mockQuerySnapshot,
          [],
          'user1',
        );

        // when
        final actual = await target.findWithNickname('user1');

        // then
        expect(actual, null);
      });
    });
  });
}

/// collectionからのデータ取得のモック
void defaultGetMock(
  MockFirebaseFirestore mockFirebaseFirestore,
  MockDocumentSnapshot<VirtualPilgrimageUser> mockDocumentSnapshot,
  MockCollectionReference<Map<String, dynamic>> mockCollectionReference,
  MockDocumentReference<VirtualPilgrimageUser> mockUserDocumentReference,
  MockDocumentReference<Map<String, dynamic>> mockMapDocumentReference,
  VirtualPilgrimageUser user,
) {
  when(mockDocumentSnapshot.data()).thenReturn(user);
  when(mockDocumentSnapshot.exists).thenReturn(true);
  when(mockUserDocumentReference.get()).thenAnswer(
    (_) => Future.value(mockDocumentSnapshot),
  );
  when(
    mockMapDocumentReference.withConverter<VirtualPilgrimageUser>(
      fromFirestore: anyNamed('fromFirestore'),
      toFirestore: anyNamed('toFirestore'),
    ),
  ).thenReturn(mockUserDocumentReference);
  when(mockCollectionReference.doc(user.id))
      .thenReturn(mockMapDocumentReference);
  when(mockFirebaseFirestore.collection('users'))
      .thenReturn(mockCollectionReference);
}

/// collectionへのデータ更新のモック
void defaultUpdateMock(
  MockFirebaseFirestore mockFirebaseFirestore,
  MockCollectionReference<Map<String, dynamic>> mockCollectionReference,
  MockDocumentReference<Map<String, dynamic>> mockMapDocumentReference,
  VirtualPilgrimageUser user,
) {
  when(mockFirebaseFirestore.collection('users'))
      .thenReturn(mockCollectionReference);
  when(mockCollectionReference.doc(user.id))
      .thenReturn(mockMapDocumentReference);
  when(mockMapDocumentReference.set(user.toJson()))
      .thenAnswer((_) => Future.value());
}

/// collectionからのニックネーム指定時のデータ取得のモック
void defaultFindWithNicknameMock(
  MockFirebaseFirestore mockFirebaseFirestore,
  MockCollectionReference<Map<String, dynamic>> mockCollectionReference,
  MockQuery<Map<String, dynamic>> mockQuery,
  MockQuery<VirtualPilgrimageUser> mockQueryAfterConverted,
  MockQuerySnapshot<VirtualPilgrimageUser> mockQuerySnapshot,
  List<VirtualPilgrimageUser> users,
  String nickname,
) {
  final mockQueryDocumentSnapshots =
      users.map(MockQueryDocumentSnapshot.new).toList();
  when(mockQuerySnapshot.docs).thenReturn(mockQueryDocumentSnapshots);
  when(mockQuerySnapshot.size).thenReturn(users.length);
  when(mockQueryAfterConverted.get()).thenAnswer(
    (_) => Future.value(mockQuerySnapshot),
  );
  when(
    mockQuery.withConverter<VirtualPilgrimageUser>(
      fromFirestore: anyNamed('fromFirestore'),
      toFirestore: anyNamed('toFirestore'),
    ),
  ).thenReturn(mockQueryAfterConverted);
  when(mockCollectionReference.where('nickname', isEqualTo: nickname))
      .thenReturn(mockQuery);
  when(mockFirebaseFirestore.collection('users'))
      .thenReturn(mockCollectionReference);
}

VirtualPilgrimageUser defaultUser([
  String userId = 'dummyId',
  String nickname = 'dummyName',
]) {
  return VirtualPilgrimageUser(
    id: userId,
    nickname: nickname,
    email: 'test@example.com',
    birthDay: DateTime.utc(2000),
    userStatus: UserStatus.created,
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/pilgrimage_info.codegen.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/user/user_repository_impl.dart';

import '../../helper/mock.mocks.dart';
import '../../helper/mock_query_document_snapshot.dart';
import '../../helper/provider_container.dart';

void main() {
  final logger = Logger(level: Level.error);

  late MockFirebaseFirestore mockFirebaseFirestore;
  late UserRepositoryImpl target;

  late MockDocumentSnapshot<VirtualPilgrimageUser> mockDocumentSnapshot;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<VirtualPilgrimageUser> mockUserDocumentReference;
  late MockDocumentReference<Map<String, dynamic>> mockMapDocumentReference;
  late MockQuery<Map<String, dynamic>> mockQuery;
  late MockQuery<VirtualPilgrimageUser> mockQueryDomainUser;
  late MockQuerySnapshot<VirtualPilgrimageUser> mockQuerySnapshot;

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

  group('UserRepositoryImpl', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final repository = container.read(userRepositoryProvider);
      expect(repository, isNotNull);
    });

    group('get', () {
      const userId = 'dummy';
      final expected = defaultUser(userId);
      setUp(() {
        when(mockDocumentSnapshot.data()).thenReturn(expected);
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
        when(mockCollectionReference.doc(userId)).thenReturn(mockMapDocumentReference);
        when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);
      });

      group('正常系', () {
        test('ユーザ情報が取得できる', () async {
          // when
          final actual = await target.get(userId);

          // then
          expect(actual, expected);
          verify(mockFirebaseFirestore.collection('users')).called(1);
        });

        test('指定したIDのユーザが存在しない', () async {
          // given
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
            when(mockFirebaseFirestore.collection('users')).thenThrow(param.value);

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
      setUp(() {
        when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);
        when(mockCollectionReference.doc(user.id)).thenReturn(mockMapDocumentReference);
        when(mockMapDocumentReference.set(user.toJson())).thenAnswer((_) => Future.value());
      });

      group('正常系', () {
        test('ユーザ情報が更新・作成できる', () async {
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
            when(mockFirebaseFirestore.collection('users')).thenThrow(param.value);

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
        final mockQueryDocumentSnapshots = [
          MockQueryDocumentSnapshot<VirtualPilgrimageUser>(users[0], MockDocumentReference()),
          MockQueryDocumentSnapshot<VirtualPilgrimageUser>(users[1], MockDocumentReference()),
        ];
        setUp(() {
          when(mockQuerySnapshot.docs).thenReturn(mockQueryDocumentSnapshots);
          when(mockQuerySnapshot.size).thenReturn(users.length);
          when(mockQueryDomainUser.get()).thenAnswer(
            (_) => Future.value(mockQuerySnapshot),
          );
          when(
            mockQuery.withConverter<VirtualPilgrimageUser>(
              fromFirestore: anyNamed('fromFirestore'),
              toFirestore: anyNamed('toFirestore'),
            ),
          ).thenReturn(mockQueryDomainUser);
          when(mockCollectionReference.where('nickname', isEqualTo: anyNamed('isEqualTo')))
              .thenReturn(mockQuery);
          when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);
        });

        test('指定したニックネームのユーザが取得できる', () async {
          // when
          final actual = await target.findWithNickname('user1');

          // then
          expect(actual, users[0]);
        });
        test('指定したニックネームのユーザが存在しない', () async {
          // given
          when(mockQuerySnapshot.docs).thenReturn([]);
          when(mockQuerySnapshot.size).thenReturn(0);
          when(mockQueryDomainUser.get()).thenAnswer(
            (_) => Future.value(mockQuerySnapshot),
          );
          when(
            mockQuery.withConverter<VirtualPilgrimageUser>(
              fromFirestore: anyNamed('fromFirestore'),
              toFirestore: anyNamed('toFirestore'),
            ),
          ).thenReturn(mockQueryDomainUser);
          when(mockCollectionReference.where('nickname', isEqualTo: 'name1')).thenReturn(mockQuery);
          when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);

          // when
          final actual = await target.findWithNickname('user1');

          // then
          expect(actual, null);
        });
      });
    });
  });
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
    createdAt: CustomizableDateTime.current,
    updatedAt: CustomizableDateTime.current,
    pilgrimage: PilgrimageInfo(id: userId, updatedAt: CustomizableDateTime.current),
  );
}

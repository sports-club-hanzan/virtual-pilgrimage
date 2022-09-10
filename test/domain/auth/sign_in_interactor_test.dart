import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/auth/sign_in_interactor.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/exception/sign_in_exception.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/auth/email_and_password_auth_repository.dart';
import 'package:virtualpilgrimage/infrastructure/auth/google_auth_repository.dart';

import 'sign_in_interactor_test.mocks.dart';

@GenerateMocks([
  EmailAndPasswordAuthRepository,
  GoogleAuthRepository,
  UserRepository,
  FirebaseCrashlytics,
  FirebaseAuth,
  UserCredential,
  User,
])
void main() {
  MockEmailAndPasswordAuthRepository mockEmailAndPasswordAuthRepository =
      MockEmailAndPasswordAuthRepository();
  MockGoogleAuthRepository mockGoogleAuthRepository = MockGoogleAuthRepository();
  MockUserRepository mockUserRepository = MockUserRepository();
  MockFirebaseCrashlytics mockFirebaseCrashlytics = MockFirebaseCrashlytics();
  MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final logger = Logger(level: Level.nothing);

  SignInInteractor target = SignInInteractor(
    mockEmailAndPasswordAuthRepository,
    mockGoogleAuthRepository,
    mockUserRepository,
    logger,
    mockFirebaseCrashlytics,
    mockFirebaseAuth,
  );

  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  const userId = 'dummyId';

  setUp(() {
    mockEmailAndPasswordAuthRepository = MockEmailAndPasswordAuthRepository();
    mockGoogleAuthRepository = MockGoogleAuthRepository();
    mockUserRepository = MockUserRepository();
    mockFirebaseCrashlytics = MockFirebaseCrashlytics();
    mockFirebaseAuth = MockFirebaseAuth();
    target = SignInInteractor(
      mockEmailAndPasswordAuthRepository,
      mockGoogleAuthRepository,
      mockUserRepository,
      logger,
      mockFirebaseCrashlytics,
      mockFirebaseAuth,
    );
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
  });

  group('signInWithGoogle', () {
    group('正常系', () {
      test('ユーザが既に存在し、サインインできる', () async {
        // given
        defaultMockSignInWithGoogle(
          mockGoogleAuthRepository,
          mockUserRepository,
          mockFirebaseCrashlytics,
          userId,
          mockUserCredential,
          mockUser,
        );
        final expected = defaultUser(id: userId);

        // when
        final actual = await target.signInWithGoogle();

        // then
        expect(actual, expected);
        verify(mockGoogleAuthRepository.signIn()).called(1);
        verify(mockFirebaseCrashlytics.setUserIdentifier(userId)).called(1);
        verify(mockUserRepository.get(userId)).called(1);
        verifyNever(mockUserRepository.update(any)).called(0); // ユーザが存在していたので更新は実行されない
      });

      test('ユーザが存在しないため、作成してサインインできる', () async {
        // given
        defaultMockSignInWithGoogle(
          mockGoogleAuthRepository,
          mockUserRepository,
          mockFirebaseCrashlytics,
          userId,
          mockUserCredential,
          mockUser,
        );
        when(mockUserRepository.get(userId)).thenAnswer((_) => Future.value(null));

        final expected = defaultUser(id: userId).copyWith(
          birthDay: DateTime.utc(1980, 1, 1),
          userIconUrl: 'http://example.com',
          userStatus: UserStatus.temporary,
        );

        // when
        final actual = await target.signInWithGoogle();

        // then
        expect(actual, expected);
        verify(mockGoogleAuthRepository.signIn()).called(1);
        verify(mockFirebaseCrashlytics.setUserIdentifier(userId)).called(1);
        verify(mockUserRepository.get(userId)).called(1);
        verify(mockUserRepository.update(expected)).called(1); // ユーザが存在していなかったので更新を実行
      });
    });

    group('異常系', () {
      test('Credential が空', () async {
        // given
        defaultMockSignInWithGoogle(
          mockGoogleAuthRepository,
          mockUserRepository,
          mockFirebaseCrashlytics,
          userId,
          mockUserCredential,
          mockUser,
        );
        when(mockGoogleAuthRepository.signIn()).thenAnswer((_) => Future.value(null));

        // when, then
        expect(
          () => target.signInWithGoogle(),
          throwsA(const TypeMatcher<SignInException>()),
        );
        verify(mockGoogleAuthRepository.signIn()).called(1);
        verifyNever(mockUserRepository.get(any)).called(0);
      });

      test('ユーザ情報取得時に例外', () async {
        // given
        defaultMockSignInWithGoogle(
          mockGoogleAuthRepository,
          mockUserRepository,
          mockFirebaseCrashlytics,
          userId,
          mockUserCredential,
          mockUser,
        );
        when(mockUserRepository.get(userId)).thenThrow(const DatabaseException(message: 'dummy'));

        // when, then
        expect(
          () => target.signInWithGoogle(),
          throwsA(const TypeMatcher<SignInException>()),
        );
        verify(mockGoogleAuthRepository.signIn()).called(1);
        verifyNever(mockUserRepository.get(any)).called(0);
        verifyNever(mockUserRepository.update(any)).called(0);
      });

      test('ユーザ情報更新時に例外', () async {
        // given
        defaultMockSignInWithGoogle(
          mockGoogleAuthRepository,
          mockUserRepository,
          mockFirebaseCrashlytics,
          userId,
          mockUserCredential,
          mockUser,
        );
        when(mockUserRepository.get(userId)).thenAnswer((_) => Future.value(null));

        when(mockUserRepository.update(any)).thenThrow(
          DatabaseException(
            message: 'dummy',
            cause: FirebaseException(plugin: 'dummy', stackTrace: StackTrace.current),
          ),
        );

        // when, then
        expect(
          () => target.signInWithGoogle(),
          throwsA(const TypeMatcher<SignInException>()),
        );
        verify(mockGoogleAuthRepository.signIn()).called(1);
        verifyNever(mockUserRepository.get(any)).called(0);
        verifyNever(mockUserRepository.update(any)).called(0);
      });

      test('ユーザ情報更新時に未知の例外', () async {
        // given
        defaultMockSignInWithGoogle(
          mockGoogleAuthRepository,
          mockUserRepository,
          mockFirebaseCrashlytics,
          userId,
          mockUserCredential,
          mockUser,
        );
        when(mockUserRepository.get(userId)).thenAnswer((_) => Future.value(null));

        /// 条件網羅のため、DatabaseException ではなく、Exception にしている
        when(mockUserRepository.update(any)).thenThrow(Exception('dummy'));

        // when, then
        expect(
          () => target.signInWithGoogle(),
          throwsA(const TypeMatcher<SignInException>()),
        );
        verify(mockGoogleAuthRepository.signIn()).called(1);
        verifyNever(mockUserRepository.get(any)).called(0);
        verifyNever(mockUserRepository.update(any)).called(0);
      });
    });
  });

  // signInWithGoogle のテストで signInWithCredentialUser のテストが担保できているため
  // こちらでのテストは最低限とする
  group('signInWithEmailAndPassword', () {
    const email = 'test@example.com';
    const password = 'Passw0rd123';
    group('正常系', () {
      test('ユーザが既に存在し、サインインできる', () async {
        // given
        defaultMockSignInWithEmailAndPassword(
          mockEmailAndPasswordAuthRepository,
          mockUserRepository,
          mockFirebaseCrashlytics,
          email,
          password,
          userId,
          mockUserCredential,
          mockUser,
        );
        final expected = defaultUser(id: userId);

        // when
        final actual = await target.signInWithEmailAndPassword(email, password);

        // then
        expect(actual, expected);
        verify(mockEmailAndPasswordAuthRepository.signIn(email: email, password: password))
            .called(1);
        verify(mockFirebaseCrashlytics.setUserIdentifier(userId)).called(1);
        verify(mockUserRepository.get(userId)).called(1);
        verifyNever(mockUserRepository.update(any)).called(0); // ユーザが存在していたので更新は実行されない
      });
    });

    group('異常系', () {
      test('Credential が空', () async {
        // given
        defaultMockSignInWithEmailAndPassword(
          mockEmailAndPasswordAuthRepository,
          mockUserRepository,
          mockFirebaseCrashlytics,
          email,
          password,
          userId,
          mockUserCredential,
          mockUser,
        );
        when(mockEmailAndPasswordAuthRepository.signIn(email: email, password: password))
            .thenAnswer((_) => Future.value(null));

        // when, then
        expect(
          () => target.signInWithEmailAndPassword(email, password),
          throwsA(const TypeMatcher<SignInException>()),
        );
        verify(mockEmailAndPasswordAuthRepository.signIn(email: email, password: password))
            .called(1);
        verifyNever(mockUserRepository.get(any)).called(0);
      });
    });
  });

  group('logout', () {
    test('正常系', () async {
      // given
      when(mockFirebaseAuth.signOut()).thenAnswer((realInvocation) => Future.value());

      // when
      await target.logout();

      // then
      verify(mockFirebaseAuth.signOut()).called(1);
    });
  });
}

void defaultMockSignInWithCredentialUser(
  MockUserRepository mockUserRepository,
  MockFirebaseCrashlytics mockFirebaseCrashlytics,
  String userId,
) {
  when(mockUserRepository.get(userId)).thenAnswer((_) => Future.value(defaultUser(id: userId)));
  when(mockUserRepository.update(any)).thenAnswer((_) => Future.value());
  // TODO(s14t284): FirebaseCrashlyticsのモックは他のテストで使うはずなので共通化したい
  when(mockFirebaseCrashlytics.log(any)).thenAnswer((_) => Future.value());
  when(mockFirebaseCrashlytics.recordError(any, any, reason: 'DatabaseException'))
      .thenAnswer((_) => Future.value());
  when(mockFirebaseCrashlytics.recordError(any, any, reason: 'Exception'))
      .thenAnswer((_) => Future.value());
  when(mockFirebaseCrashlytics.setUserIdentifier(any)).thenAnswer((_) => Future.value());
}

void defaultMockSignInWithGoogle(
  MockGoogleAuthRepository mockGoogleAuthRepository,
  MockUserRepository mockUserRepository,
  MockFirebaseCrashlytics mockFirebaseCrashlytics,
  String userId,
  MockUserCredential mockUserCredential,
  MockUser mockUser,
) {
  when(mockUser.uid).thenReturn(userId);
  when(mockUser.email).thenReturn('test@example.com');
  when(mockUser.displayName).thenReturn('dummyName');
  when(mockUser.photoURL).thenReturn('http://example.com');
  when(mockUserCredential.user).thenReturn(mockUser);
  when(mockGoogleAuthRepository.signIn()).thenAnswer((_) => Future.value(mockUserCredential));
  defaultMockSignInWithCredentialUser(mockUserRepository, mockFirebaseCrashlytics, userId);
}

void defaultMockSignInWithEmailAndPassword(
  MockEmailAndPasswordAuthRepository mockEmailAndPasswordAuthRepository,
  MockUserRepository mockUserRepository,
  MockFirebaseCrashlytics mockFirebaseCrashlytics,
  String email,
  String password,
  String userId,
  MockUserCredential mockUserCredential,
  MockUser mockUser,
) {
  when(mockUser.uid).thenReturn(userId);
  when(mockUser.email).thenReturn(email);
  when(mockUser.displayName).thenReturn('dummyName');
  when(mockUser.photoURL).thenReturn('http://example.com');
  when(mockUserCredential.user).thenReturn(mockUser);
  when(mockEmailAndPasswordAuthRepository.signIn(email: email, password: password))
      .thenAnswer((realInvocation) => Future.value(mockUserCredential));
  defaultMockSignInWithCredentialUser(mockUserRepository, mockFirebaseCrashlytics, userId);
}

VirtualPilgrimageUser defaultUser({String id = 'dummyId'}) {
  return VirtualPilgrimageUser(
    id: id,
    nickname: 'dummyName',
    birthDay: DateTime.utc(2000),
    email: 'test@example.com',
    userIconUrl: '',
    userStatus: UserStatus.created,
  );
}
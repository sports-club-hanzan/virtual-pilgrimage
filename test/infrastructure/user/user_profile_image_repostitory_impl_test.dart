import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/application/user/profile/user_profile_image_repository.dart';
import 'package:virtualpilgrimage/infrastructure/user/user_profile_image_repository_impl.dart';

import '../../helper/mock.mocks.dart';
import '../../helper/provider_container.dart';

void main() {
  late UserProfileImageRepositoryImpl target;
  late MockFirebaseStorage storage;
  final logger = Logger(level: Level.nothing);

  final mockStorageRef = MockReference();
  final mockProfileImageStorageRef = MockReference();
  final mockUploadTask = MockUploadTask();

  setUp(() {
    storage = MockFirebaseStorage();
    target = UserProfileImageRepositoryImpl(storage, logger);
  });

  group('UserProfileImageRepositoryImpl', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final actual = container.read(userProfileImageRepositoryProvider);
      expect(actual, isNotNull);
    });

    group('uploadProfileImage', () {
      final imageFile = MockFile();
      const userId = 'dummyId';
      const profileImageUrl = 'https://dummy.png';
      test('正常系', () async {
        // given
        when(mockProfileImageStorageRef.putFile(imageFile)).thenAnswer((_) => mockUploadTask);
        when(mockProfileImageStorageRef.getDownloadURL())
            .thenAnswer((_) => Future.value(profileImageUrl));
        when(mockStorageRef.child('users/dummyId/profile.png'))
            .thenReturn(mockProfileImageStorageRef);
        when(storage.ref()).thenReturn(mockStorageRef);

        // when
        final actual = await target.uploadProfileImage(imageFile: imageFile, userId: userId);

        // then
        expect(actual, profileImageUrl);
        verify(mockProfileImageStorageRef.putFile(imageFile)).called(1);
        verify(mockProfileImageStorageRef.getDownloadURL()).called(1);
      });
    });

    group('getProfileImageUrl', () {
      const profileImageUrl = 'https://dummy.png';
      test('正常系', () async {
        // given
        when(mockProfileImageStorageRef.getDownloadURL())
            .thenAnswer((_) => Future.value(profileImageUrl));
        when(mockStorageRef.child('users/dummyId/profile.png'))
            .thenReturn(mockProfileImageStorageRef);
        when(storage.ref()).thenReturn(mockStorageRef);

        // when
        final actual = await target.getProfileImageUrl(userId: 'dummyId');

        // then
        expect(actual, profileImageUrl);
        verify(mockProfileImageStorageRef.getDownloadURL()).called(1);
      });
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/user/profile/update_user_profile_image_interactor.dart';
import 'package:virtualpilgrimage/domain/user/profile/update_user_profile_image_usecase.dart';
import 'package:virtualpilgrimage/domain/user/profile/user_profile_image_repository.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

import '../../../helper/mock.mocks.dart';
import '../../../helper/provider_container.dart';
import 'update_user_profile_image_interactor_test.mocks.dart';

@GenerateMocks([UserRepository, UserProfileImageRepository])
void main() {
  late UpdateUserProfileImageInteractor target;
  late UserRepository userRepository;
  late UserProfileImageRepository userProfileImageRepository;

  setUp(() {
    userRepository = MockUserRepository();
    userProfileImageRepository = MockUserProfileImageRepository();
    target = UpdateUserProfileImageInteractor(userRepository, userProfileImageRepository);
  });

  group('UpdateUserProfileImageInteractor', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final actual = container.read(updateUserProfileImageUsecaseProvider);
      expect(actual, isNotNull);
    });

    group('execute', () {
      setUp(() {
        CustomizableDateTime.customTime = DateTime.now();
      });
      test('正常系', () async {
        // given
        final user = VirtualPilgrimageUser(
          id: 'dummyId',
          userIconUrl: 'https://profile.png',
          // URLが書き変わることを確認するため、他の値を入れている
          birthDay: DateTime(1990, 1, 1),
          createdAt: DateTime(2022, 10, 10),
          updatedAt: DateTime(2022, 10, 10),
        );
        final expected = user.copyWith(
          userIconUrl: 'https://dummy.png',
          updatedAt: CustomizableDateTime.current,
        );
        final imageFile = MockFile();
        when(userProfileImageRepository.uploadProfileImage(imageFile: imageFile, userId: 'dummyId'))
            .thenAnswer((_) => Future.value('https://dummy.png'));
        when(userRepository.update(expected)).thenAnswer((_) => Future.value());

        // when
        final actual = await target.execute(user: user, imageFile: imageFile);

        // then
        expect(actual, expected);
        verify(
          userProfileImageRepository.uploadProfileImage(imageFile: imageFile, userId: 'dummyId'),
        ).called(1);
        verify(userRepository.update(expected)).called(1);
      });
    });
  });
}
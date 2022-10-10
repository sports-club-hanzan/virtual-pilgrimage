import 'dart:io';

import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/user/profile/update_user_profile_image_usecase.dart';
import 'package:virtualpilgrimage/domain/user/profile/user_profile_image_repository.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

// ユーザのプロフィール画像を更新するUsecaseの実装
class UpdateUserProfileImageInteractor extends UpdateUserProfileImageUsecase {
  UpdateUserProfileImageInteractor(
    this._userRepository,
    this._userProfileImageRepository,
  );

  final UserRepository _userRepository;
  final UserProfileImageRepository _userProfileImageRepository;

  /// ユーザのプロフィール画像を更新
  /// 後のstate更新のため、更新したユーザ情報を返す
  ///
  /// [user] 更新対象のユーザ
  /// [imageFile] プロフィール画像を保持したインスタンス
  @override
  Future<VirtualPilgrimageUser> execute({
    required VirtualPilgrimageUser user,
    required File imageFile,
  }) async {
    // 画像をアップロード
    final profileImageUrl = await _userProfileImageRepository.uploadProfileImage(
      imageFile: imageFile,
      userId: user.id,
    );

    // 最後にFirestoreに保存して state を更新
    final updatedUser = user.copyWith(
      userIconUrl: profileImageUrl,
      updatedAt: CustomizableDateTime.current,
    );
    await _userRepository.update(updatedUser);

    return updatedUser;
  }
}

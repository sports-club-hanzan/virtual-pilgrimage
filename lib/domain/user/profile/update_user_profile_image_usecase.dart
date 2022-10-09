import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/profile/update_user_profile_image_interactor.dart';
import 'package:virtualpilgrimage/domain/user/profile/user_profile_image_repository.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

final updateUserProfileImageUsecaseProvider = Provider<UpdateUserProfileImageUsecase>(
  (ref) => UpdateUserProfileImageInteractor(
    ref.read(userRepositoryProvider),
    ref.read(userProfileImageRepositoryProvider),
  ),
);

abstract class UpdateUserProfileImageUsecase {
  /// ユーザのプロフィール画像を更新
  /// 後のstate更新のため、更新したユーザ情報を返す
  ///
  /// [user] 更新対象のユーザ
  /// [imageFile] プロフィール画像を保持したインスタンス
  Future<VirtualPilgrimageUser> execute({
    required VirtualPilgrimageUser user,
    required File imageFile,
  });
}

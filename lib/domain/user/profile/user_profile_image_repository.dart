import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/storage_provider.dart';
import 'package:virtualpilgrimage/infrastructure/user/user_profile_image_repository_impl.dart';
import 'package:virtualpilgrimage/logger.dart';

final userProfileImageRepositoryProvider = Provider<UserProfileImageRepository>(
  (ref) => UserProfileImageRepositoryImpl(ref.read(storageProvider), ref.read(loggerProvider)),
);

abstract class UserProfileImageRepository {
  /// プロフィール画像をCloudStorageにアップロードしてアップロード先のURLを返す
  ///
  /// [imageFile] プロフィール画像にしたいファイル
  /// [userId] プロフィール画像をアップロードしようとしているユーザのID
  Future<String> uploadProfileImage({required File imageFile, required String userId});

  /// プロフィール画像のアップロード先のURLを返す
  ///
  /// [userId] プロフィール画像のURLを取得したいユーザのID
  Future<String> getProfileImageUrl({required String userId});
}

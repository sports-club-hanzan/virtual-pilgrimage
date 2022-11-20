import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:virtualpilgrimage/application/user/profile/user_profile_image_repository.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/cloudstorage_collection_path.dart';

class UserProfileImageRepositoryImpl extends UserProfileImageRepository {
  UserProfileImageRepositoryImpl(this._firestoreClient, this._logger);

  final FirebaseStorage _firestoreClient;
  final Logger _logger;

  /// プロフィール画像をCloudStorageにアップロードしてアップロード先のURLを返す
  ///
  /// [imageFile] プロフィール画像にしたいファイル
  /// [userId] プロフィール画像をアップロードしようとしているユーザのID
  @override
  Future<String> uploadProfileImage({required File imageFile, required String userId}) async {
    // 変数に結果を入れない&以下のコメントがないとlinterに怒られるのでignoreコメントを付与
    // ignore:unused_local_variable
    final snapshot = _ref(userId).putFile(imageFile);
    final url = await getProfileImageUrl(userId: userId);

    _logger.d('uploading user profile image success. [userId][$userId][url][$url]');

    return url;
  }

  /// プロフィール画像のアップロード先のURLを返す
  ///
  /// [userId] プロフィール画像のURLを取得したいユーザのID
  @override
  Future<String> getProfileImageUrl({required String userId}) async {
    final ref = _ref(userId);
    final url = await ref.getDownloadURL();
    _logger.d('user profile image url [userId][$userId][url][$url]');
    return url;
  }

  Reference _ref(String userId) {
    return _firestoreClient.ref().child(CloudStorageCollectionPath.user(userId));
  }
}

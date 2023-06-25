import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/application/user/profile/update_user_profile_image_usecase.dart';
import 'package:virtualpilgrimage/application/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/exception/database_exception.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_state.codegen.dart';

final profileUserProvider =
    FutureProvider.family.autoDispose<VirtualPilgrimageUser?, String>((ref, userId) async {
  // 常に最新の値を取りに行くため、DBに問い合わせる
  final user = await ref.read(userRepositoryProvider).get(userId);
  // ログインユーザ以外を指定していた場合
  return user?.convertForProfile();
});

final profileProvider =
    StateNotifierProvider.autoDispose<ProfilePresenter, ProfileState>(ProfilePresenter.new);

class ProfilePresenter extends StateNotifier<ProfileState> {
  ProfilePresenter(this._ref) : super(ProfileState(selectedTabIndex: 0)) {
    _updateUserProfileImageInteractor = _ref.read(updateUserProfileImageUsecaseProvider);
    _analytics = _ref.read(analyticsProvider);
    _crashlytics = _ref.read(firebaseCrashlyticsProvider);
  }

  final Ref _ref;
  late final UpdateUserProfileImageUsecase _updateUserProfileImageInteractor;
  late final Analytics _analytics;
  late final FirebaseCrashlytics _crashlytics;

  final _selectedTabs = ['今日', '昨日', '週間', '月間'];
  final _genderString = ['', '男性', '女性'];

  List<String> tabLabels() => _selectedTabs;

  /// ヘルスケア情報のタブ選択の切り替えを行う
  Future<void> setSelectedTabIndex(int index) async => state = state.onTapHealthTab(index);

  /// 性別の表示文字列を取得
  String getGenderString(Gender gender) => _genderString[gender.index];

  /// 年代の表示文字列を取得
  String getAgeString(DateTime birthday) {
    // 年齢を導出し、年代に変換して表示文字列を成形
    // ex. 71歳
    // floor(71 / 10) * 10 = floor(7.1) * 10 = 7 * 10 = 70
    // => 70代
    final age = _calcAge(birthday);
    return '${(age / 10).floor() * 10}代';
  }

  /// datetime から年齢を計算するロジック。
  ///
  /// ex. 当日: 20221001, 誕生日: 19501201 (71歳)
  /// floor((20221001 - 19501201)/10000) = floor(719800 / 10000) = floor(71.98) = 71
  /// FIXME: 流用するならば domain service にロジックを移す
  int _calcAge(DateTime birthday) {
    final today = CustomizableDateTime.current;
    final todayYYYYMMDD = today.year * 10000 + today.month * 100 + today.day;
    final birthdayYYYYMDD = birthday.year * 10000 + birthday.month * 100 + birthday.day;
    return ((todayYYYYMMDD - birthdayYYYYMDD) / 10000).floor();
  }

  /// プロフィール画像を更新する
  ///
  /// 更新できない時 false
  Future<bool> updateProfileImage(BuildContext context) async {
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.pressedUploadImage));
    final loginUser = _ref.watch(userStateProvider)!;

    // カメラロールから画像を選択させる
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.gallery, maxHeight: 128, maxWidth: 128);
    // 取得できた画像情報が空だったら更新しない
    if (image == null) {
      unawaited(_crashlytics.log('failed to open image for upload profile image'));
      return false;
    }

    try {
      await _updateUserProfileImageInteractor.execute(user: loginUser, imageFile: File(image.path));
    } on DatabaseException catch (e) {
      unawaited(_crashlytics.recordError(e, null));
      return false;
    }
    return true;
  }
}

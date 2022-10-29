import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtualpilgrimage/analytics.dart';
import 'package:virtualpilgrimage/domain/customizable_date_time.dart';
import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/domain/user/health/update_health_result.dart';
import 'package:virtualpilgrimage/domain/user/health/update_health_usecase.dart';
import 'package:virtualpilgrimage/domain/user/profile/update_user_profile_image_usecase.dart';
import 'package:virtualpilgrimage/domain/user/user_icon_repository.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/logger.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_state.codegen.dart';

final profileUserProvider =
    FutureProvider.family<VirtualPilgrimageUser?, String>((ref, userId) async {
  // ログイン状態でしか呼ばれないため、nullable を想定していない
  final loginUser = ref.read(userStateProvider)!;
  // ログインユーザ自身を指定していた場合
  if (loginUser.id == userId) {
    // ヘルスケア情報をとりにいく
    final result = await ref.read(updateHealthUsecaseProvider).execute(loginUser);
    // ヘルスケア情報が上手く取れた場合は更新後のユーザ情報を返す
    if (result.status == UpdateHealthStatus.success) {
      ref.read(loggerProvider).d(result);
      ref.read(userStateProvider.notifier).state = result.updatedUser;
      return result.updatedUser;
    } else {
      ref.read(loggerProvider).e(result);
      await ref.read(firebaseCrashlyticsProvider).recordError(
            result.error,
            null,
            reason: 'failed to record health information [status][${result.status}]',
          );
    }
    return loginUser;
  }
  // そうでなければDBに問い合わせ
  return ref.read(userRepositoryProvider).get(userId);
});

final profileProvider =
    StateNotifierProvider.autoDispose<ProfilePresenter, ProfileState>(ProfilePresenter.new);

class ProfilePresenter extends StateNotifier<ProfileState> {
  ProfilePresenter(this._ref) : super(ProfileState(selectedTabIndex: 0)) {
    _updateUserProfileImageInteractor = _ref.read(updateUserProfileImageUsecaseProvider);
    _userIconRepository = _ref.read(userIconRepositoryProvider);
    _analytics = _ref.read(analyticsProvider);
  }

  final Ref _ref;
  late final UpdateUserProfileImageUsecase _updateUserProfileImageInteractor;
  late final UserIconRepository _userIconRepository;
  late final Analytics _analytics;

  final _selectedTabs = ['今日', '昨日', '週間', '月間'];
  final _genderString = ['', '男性', '女性'];
  final maxTempleNumber = 88;

  List<String> tabLabels() => _selectedTabs;

  /// ヘルスケア情報のタブ選択の切り替えを行う
  Future<void> setSelectedTabIndex(int index) async {
    state = state.copyWith(selectedTabIndex: index);
  }

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
  Future<void> updateProfileImage() async {
    unawaited(_analytics.logEvent(eventName: AnalyticsEvent.pressedUploadImage));
    final loginUser = _ref.watch(userStateProvider)!;

    // カメラロールから画像を選択させる
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, maxHeight: 64, maxWidth: 64);
    // 空だったら更新しない
    // FIXME: ユーザに画像が保存できなかった旨のpopupを見せたい
    if (image == null) {
      return;
    }

    final updatedUser = await _updateUserProfileImageInteractor.execute(
      user: loginUser,
      imageFile: File(image.path),
    );
    // GoogleMap 上で表示する userIcon も更新してstateを更新
    final bitmap = await _userIconRepository.loadIconImage(updatedUser.userIconUrl);
    _ref.read(userStateProvider.state).state = updatedUser.setUserIconBitmap(bitmap);
  }

  /// ユーザの現在到達している地点のお寺の情報を返す
  ///
  /// [user] プロフィールを参照しているユーザ
  Future<TempleInfo> getNowPilgrimageTempleInfo(VirtualPilgrimageUser user) {
    return _ref.read(templeRepositoryProvider).getTempleInfo(user.pilgrimage.nowPilgrimageId);
  }

  /// ユーザが向かっているのお寺の情報を返す
  ///
  /// [user] プロフィールを参照しているユーザ
  Future<TempleInfo> getNextPilgrimageTempleInfo(VirtualPilgrimageUser user) {
    return _ref.read(templeRepositoryProvider).getTempleInfo(
          _nextPilgrimageNumber(user.pilgrimage.nowPilgrimageId),
        );
  }

  /// m単位の数値をkm単位に補正した文字列を返す
  ///
  /// [meter] m単位の数値
  String meterToKilometerString(int meter) {
    return (meter / 1000).toStringAsFixed(1);
  }

  /// 次の札所の番号を返す
  /// 88箇所目に到達していたら 1 を返す
  /// [pilgrimageId] 現在の札所の番号
  int _nextPilgrimageNumber(int pilgrimageId) {
    if (pilgrimageId < maxTempleNumber) {
      return pilgrimageId + 1;
    }
    return 1;
  }
}

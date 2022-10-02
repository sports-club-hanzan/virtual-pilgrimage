import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';
import 'package:virtualpilgrimage/ui/pages/profile/profile_state.codegen.dart';

final profileProvider = FutureProvider.family<VirtualPilgrimageUser?, String>((ref, userId) async {
  // ログイン状態でしか呼ばれないため、nullable を想定していない
  final loginUser = ref.read(userStateProvider)!;
  // ログインユーザ自身を指定していた場合はそのまま返す
  if (loginUser.id == userId) {
    return loginUser;
  }
  // そうでなければDBに問い合わせ
  return ref.read(userRepositoryProvider).get(userId);
});

final profilePresenter = StateNotifierProvider.autoDispose<ProfilePresenter, ProfileState>(
  (ref) => ProfilePresenter(),
);

class ProfilePresenter extends StateNotifier<ProfileState> {
  ProfilePresenter() : super(ProfileState(selectedTabIndex: 0));

  final _selectedTabs = ['昨日', '週間', '月間'];
  final _genderString = ['性別未設定', '男性', '女性'];

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
    final today = DateTime.now();
    final todayYYYYMMDD = today.year * 10000 + today.month * 100 + today.day;
    final birthdayYYYYMDD = birthday.year * 10000 + birthday.month * 100 + birthday.day;
    return ((todayYYYYMMDD - birthdayYYYYMDD) / 10000).floor();
  }

  /// プロフィール画像を更新する
  Future<void> updateProfileImage() async {
    // TODO(s14t284): cloud storage に画像をアップロードし、firestore のプロフィール画像URLを更新する処理を実装
  }
}

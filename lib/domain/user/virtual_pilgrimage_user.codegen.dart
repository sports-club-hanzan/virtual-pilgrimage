import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'virtual_pilgrimage_user.codegen.freezed.dart';
part 'virtual_pilgrimage_user.codegen.g.dart';

final userStateProvider = StateProvider<VirtualPilgrimageUser?>((_) => null);

// 性別
enum Gender {
  // 未設定
  unknown,
  // 男性
  man,
  // 女性
  woman,
}

// ユーザの作成状態のステータス
enum UserStatus {
  // 仮登録
  temporary,
  // 登録完了
  created,
  // 削除済み
  deleted
}

// User 情報の Firestore の key
extension VirtualPilgrimageUserPrivateFirestoreFieldKeys on String {
  static const id = 'id';
  static const nickname = 'nickname';
  static const gender = 'gender';
  static const birthDay = 'birthDay';
  static const email = 'email';
  static const userIconUrl = 'userIconUrl';
}

// Gender <-> int の相互変換用クラス
class _GenderConverter {
  static Gender intToGender(int num) => Gender.values[num];
  static int genderToInt(Gender gender) => gender.index;
}

// UserStatus <-> int の相互変換用クラス
class _UserStatusConverter {
  static UserStatus intToUserStatus(int num) => UserStatus.values[num];
  static int userStatusToInt(UserStatus userStatus) => userStatus.index;
}

// DateTime <-> Timestamp の相互変換用クラス
// 共通化したいが、ここで定義しないと自動生成ファイル側で import エラーが発生する
class _FirestoreTimestampConverter {
  static Timestamp dateTimeToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);
  static DateTime timestampToDateTime(Timestamp timestamp) =>
      timestamp.toDate();
}

@freezed
class VirtualPilgrimageUser with _$VirtualPilgrimageUser {
  const VirtualPilgrimageUser._();

  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory VirtualPilgrimageUser({
    @Default('')
        String id,
    @Default('')
        String nickname,
    // ignore: invalid_annotation_target
    @JsonKey(
      fromJson: _GenderConverter.intToGender,
      toJson: _GenderConverter.genderToInt,
    )
    @Default(Gender.unknown)
        Gender gender,
    // ignore: invalid_annotation_target
    @JsonKey(
      fromJson: _FirestoreTimestampConverter.timestampToDateTime,
      toJson: _FirestoreTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime birthDay,
    @Default('')
        String email,
    @Default('')
        String userIconUrl,
    @Default(UserStatus.temporary)
    // ignore: invalid_annotation_target
    @JsonKey(
      fromJson: _UserStatusConverter.intToUserStatus,
      toJson: _UserStatusConverter.userStatusToInt,
    )
        UserStatus userStatus,
    // TODO: 以下の情報を含める
    // ヘルスケアから得られる歩数などの情報
    // 現在地のお遍路で巡っているお寺の情報
  }) = _VirtualPilgrimageUser;

  factory VirtualPilgrimageUser.fromJson(Map<String, dynamic> json) =>
      _$VirtualPilgrimageUserFromJson(json);
}

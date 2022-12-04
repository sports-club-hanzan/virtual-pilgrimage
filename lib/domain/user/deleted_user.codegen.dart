import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/domain/helper/firestore_timestamp_converter.dart';

part 'deleted_user.codegen.freezed.dart';
part 'deleted_user.codegen.g.dart';

@freezed
class DeletedUser with _$DeletedUser {
  @JsonSerializable()
  const factory DeletedUser({
    /**
     * 削除対象のユーザID
     */
    required String id,

    /**
     * 削除日時
     */
    @JsonKey(
      fromJson: FirestoreTimestampConverter.timestampToDateTime,
      toJson: FirestoreTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime deletedAt,
  }) = _DeletedUser;

  const DeletedUser._();

  factory DeletedUser.fromJson(Map<String, dynamic> json) => _$DeletedUserFromJson(json);
}

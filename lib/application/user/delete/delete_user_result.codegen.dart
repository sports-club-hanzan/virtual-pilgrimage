import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

part 'delete_user_result.codegen.freezed.dart';

enum DeleteUserStatus {
  // 削除に成功
  success,
  // 削除に失敗
  fail
}

@freezed
class DeleteUserResult with _$DeleteUserResult {
  const factory DeleteUserResult({
    required DeleteUserStatus status,
    Exception? error,
  }) = _DeleteUserResult;

  const DeleteUserResult._();
}

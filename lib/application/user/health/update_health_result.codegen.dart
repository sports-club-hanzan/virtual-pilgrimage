import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

part 'update_health_result.codegen.freezed.dart';

enum UpdateHealthStatus {
  // 登録に成功
  success,
  // ヘルスケア情報の取得で失敗
  getHealthError,
  // DBなどで発生した例外
  updateUserError,
  // 未知の例外
  unknownError,
}

@freezed
class UpdateHealthResult with _$UpdateHealthResult {
  const factory UpdateHealthResult({
    required UpdateHealthStatus status,
    VirtualPilgrimageUser? user,
    Exception? error,
  }) = _UpdateHealthResult;

  const UpdateHealthResult._();
}

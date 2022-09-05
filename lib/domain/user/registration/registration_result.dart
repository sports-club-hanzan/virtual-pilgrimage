
enum RegistrationResultStatus {
  // 登録に成功
  success,
  // 同一名称のニックネームを持つユーザが既に存在
  alreadyExistSameNicknameUser,
  // DBなどで発生した例外
  fail
}

class RegistrationResult {
  final RegistrationResultStatus status;
  final Exception? error;

  RegistrationResult(this.status, [this.error]);
}
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

class UpdateHealthResult {
  UpdateHealthResult(this.status, [this.error]);

  final UpdateHealthStatus status;
  final Exception? error;

  @override
  bool operator ==(Object other) {
    return other is UpdateHealthResult && other.status == status && other.error == error;
  }

  @override
  int get hashCode => status.hashCode + error.hashCode;

  @override
  String toString() => 'UpdateHealthResult(status: ${status.name} error: $error)';
}
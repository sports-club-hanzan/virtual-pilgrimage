import 'package:flutter/foundation.dart';

enum UpdatePilgrimageProgressResultStatus {
  // 成功
  success,
  // DB,ヘルスケア情報の問い合わせなどで発生した例外
  fail
}

class UpdatePilgrimageProgressResult {
  UpdatePilgrimageProgressResult(this.status, this.reachedPilgrimageIdList, [this.error]);

  final UpdatePilgrimageProgressResultStatus status;
  final List<int> reachedPilgrimageIdList;
  final Exception? error;

  @override
  bool operator ==(Object other) {
    return other is UpdatePilgrimageProgressResult &&
        other.status == status &&
        listEquals(other.reachedPilgrimageIdList, reachedPilgrimageIdList) &&
        other.error == error;
  }

  @override
  int get hashCode => status.hashCode + reachedPilgrimageIdList.hashCode + error.hashCode;

  @override
  String toString() =>
      'UpdatePilgrimageProgressResult(status: ${status.name} reachedPilgrimageIdList: $reachedPilgrimageIdList error: $error)';
}

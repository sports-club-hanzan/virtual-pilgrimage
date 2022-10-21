import 'package:flutter/foundation.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

enum UpdatePilgrimageProgressResultStatus {
  // 成功
  success,
  // DB,ヘルスケア情報の問い合わせなどで発生した例外
  fail,
  // 更新対象のユーザ情報の取得に失敗した時
  failWithGetUser
}

class UpdatePilgrimageProgressResult {
  UpdatePilgrimageProgressResult(this.status, this.reachedPilgrimageIdList, this.updatedUser, [this.error]);

  final UpdatePilgrimageProgressResultStatus status;
  final List<int> reachedPilgrimageIdList;
  final VirtualPilgrimageUser? updatedUser;
  final Exception? error;

  @override
  bool operator ==(Object other) {
    return other is UpdatePilgrimageProgressResult &&
        other.status == status &&
        listEquals(other.reachedPilgrimageIdList, reachedPilgrimageIdList) &&
        other.updatedUser == updatedUser &&
        other.error == error;
  }

  @override
  int get hashCode => status.hashCode + reachedPilgrimageIdList.hashCode + error.hashCode;

  @override
  String toString() =>
      'UpdatePilgrimageProgressResult(status: ${status.name} updatedUser: $updatedUser reachedPilgrimageIdList: $reachedPilgrimageIdList error: $error)';
}

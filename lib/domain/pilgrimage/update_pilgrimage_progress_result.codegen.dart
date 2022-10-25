import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

part 'update_pilgrimage_progress_result.codegen.freezed.dart';

enum UpdatePilgrimageProgressResultStatus {
  // 成功
  success,
  // DB,ヘルスケア情報の問い合わせなどで発生した例外
  fail,
  // 更新対象のユーザ情報の取得に失敗した時
  failWithGetUser
}

@freezed
class UpdatePilgrimageProgressResult with _$UpdatePilgrimageProgressResult {
  const factory UpdatePilgrimageProgressResult({
    // お遍路の進捗更新結果の状態
    required UpdatePilgrimageProgressResultStatus status,
    // 新たに到達した札所の番号一覧
    required List<int> reachedPilgrimageIdList,
    // 現在、仮想的に移動している経路の緯度・経路のリスト
    @Default([]) List<LatLng> virtualPolylineLatLngs,
    // 現在の仮想的なユーザの緯度・軽度
    LatLng? virtualPosition,
    // ロジックによって更新されたときのユーザの情報
    VirtualPilgrimageUser? updatedUser,
    // ロジック実行時に発生したエラー
    Exception? error,
  }) = _UpdatePilgrimageProgressResult;

  const UpdatePilgrimageProgressResult._();
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pilgrimage_info.codegen.freezed.dart';
part 'pilgrimage_info.codegen.g.dart';

extension PilgrimageInfoFieldKeys on String {
  static const nowPilgrimageId = 'nowPilgrimageId';
  static const lap = 'lap';
  static const movingDistance = 'movingDistance';
}

@freezed
class PilgrimageInfo with _$PilgrimageInfo {
  const factory PilgrimageInfo({
    // Firestore のid。
    // 利用しない値なので、Firebase Authentication から取得できるidを詰める
    required String id,

    // 現在のお遍路の番所
    // 1番札所からスタートするのでデフォルト：1
    @Default(1) int nowPilgrimageId,

    // お遍路が何周目か。
    // 1週目からスタートするのでデフォルト：1
    @Default(1) int lap,

    // お寺に到着したかを参照するための移動距離
    // 次の札所に到着したかを計算する為に保存
    @Default(0) double movingDistance,
  }) = _PilgrimageInfo;
  const PilgrimageInfo._();

  factory PilgrimageInfo.fromJson(Map<String, dynamic> json) => _$PilgrimageInfoFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pilgrimage_info.codegen.freezed.dart';
part 'pilgrimage_info.codegen.g.dart';

@freezed
class PilgrimageInfo with _$PilgrimageInfo {
  @JsonSerializable(explicitToJson: true)
  const factory PilgrimageInfo({
    @Default('')
      String id,
    @Default('1')
      String nowPilgrimageId,
    @Default('')
      String lap,
}) = _PilgrimageInfo;
  const PilgrimageInfo._();

  factory PilgrimageInfo.fromJson(Map<String, dynamic> json) => _$PilgrimageInfoFromJson(json);
}

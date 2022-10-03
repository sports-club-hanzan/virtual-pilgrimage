import 'package:freezed_annotation/freezed_annotation.dart';

part 'temple_image.codegen.freezed.dart';
part 'temple_image.codegen.g.dart';

@freezed
class TempleImage with _$TempleImage {
  const factory TempleImage({
    required String path,
  }) = _TempleImage;

  const TempleImage._();

  factory TempleImage.fromJson(Map<String, dynamic> json) => _$TempleImageFromJson(json);
}

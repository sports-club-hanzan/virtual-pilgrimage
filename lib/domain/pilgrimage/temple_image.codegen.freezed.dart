// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temple_image.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TempleImage _$TempleImageFromJson(Map<String, dynamic> json) {
  return _TempleImage.fromJson(json);
}

/// @nodoc
mixin _$TempleImage {
  String get path => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TempleImageCopyWith<TempleImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempleImageCopyWith<$Res> {
  factory $TempleImageCopyWith(
          TempleImage value, $Res Function(TempleImage) then) =
      _$TempleImageCopyWithImpl<$Res, TempleImage>;
  @useResult
  $Res call({String path});
}

/// @nodoc
class _$TempleImageCopyWithImpl<$Res, $Val extends TempleImage>
    implements $TempleImageCopyWith<$Res> {
  _$TempleImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TempleImageCopyWith<$Res>
    implements $TempleImageCopyWith<$Res> {
  factory _$$_TempleImageCopyWith(
          _$_TempleImage value, $Res Function(_$_TempleImage) then) =
      __$$_TempleImageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path});
}

/// @nodoc
class __$$_TempleImageCopyWithImpl<$Res>
    extends _$TempleImageCopyWithImpl<$Res, _$_TempleImage>
    implements _$$_TempleImageCopyWith<$Res> {
  __$$_TempleImageCopyWithImpl(
      _$_TempleImage _value, $Res Function(_$_TempleImage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
  }) {
    return _then(_$_TempleImage(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TempleImage extends _TempleImage {
  const _$_TempleImage({required this.path}) : super._();

  factory _$_TempleImage.fromJson(Map<String, dynamic> json) =>
      _$$_TempleImageFromJson(json);

  @override
  final String path;

  @override
  String toString() {
    return 'TempleImage(path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TempleImage &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TempleImageCopyWith<_$_TempleImage> get copyWith =>
      __$$_TempleImageCopyWithImpl<_$_TempleImage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TempleImageToJson(
      this,
    );
  }
}

abstract class _TempleImage extends TempleImage {
  const factory _TempleImage({required final String path}) = _$_TempleImage;
  const _TempleImage._() : super._();

  factory _TempleImage.fromJson(Map<String, dynamic> json) =
      _$_TempleImage.fromJson;

  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$_TempleImageCopyWith<_$_TempleImage> get copyWith =>
      throw _privateConstructorUsedError;
}

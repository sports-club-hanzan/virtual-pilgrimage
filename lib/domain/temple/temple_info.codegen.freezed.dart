// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'temple_info.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TempleInfo _$TempleInfoFromJson(Map<String, dynamic> json) {
  return _TempleInfo.fromJson(json);
}

/// @nodoc
mixin _$TempleInfo {
// ID, お寺の番号
  int get id => throw _privateConstructorUsedError; // 名前
  String get name => throw _privateConstructorUsedError; // 都道府県
  String get prefecture => throw _privateConstructorUsedError; // 住所
  String get address => throw _privateConstructorUsedError; // 次のお寺までの距離
  int get distance => throw _privateConstructorUsedError; // 次のお寺までの経路(エンコード文字列)
  String get encodedPoints => throw _privateConstructorUsedError; // お寺のうんちく
  String get knowledge => throw _privateConstructorUsedError; // お寺の座標
  @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
  GeoPoint get geoPoint => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TempleInfoCopyWith<TempleInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempleInfoCopyWith<$Res> {
  factory $TempleInfoCopyWith(
          TempleInfo value, $Res Function(TempleInfo) then) =
      _$TempleInfoCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      String prefecture,
      String address,
      int distance,
      String encodedPoints,
      String knowledge,
      @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
          GeoPoint geoPoint,
      List<String> images});
}

/// @nodoc
class _$TempleInfoCopyWithImpl<$Res> implements $TempleInfoCopyWith<$Res> {
  _$TempleInfoCopyWithImpl(this._value, this._then);

  final TempleInfo _value;
  // ignore: unused_field
  final $Res Function(TempleInfo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? prefecture = freezed,
    Object? address = freezed,
    Object? distance = freezed,
    Object? encodedPoints = freezed,
    Object? knowledge = freezed,
    Object? geoPoint = freezed,
    Object? images = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      prefecture: prefecture == freezed
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
      encodedPoints: encodedPoints == freezed
          ? _value.encodedPoints
          : encodedPoints // ignore: cast_nullable_to_non_nullable
              as String,
      knowledge: knowledge == freezed
          ? _value.knowledge
          : knowledge // ignore: cast_nullable_to_non_nullable
              as String,
      geoPoint: geoPoint == freezed
          ? _value.geoPoint
          : geoPoint // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_TempleInfoCopyWith<$Res>
    implements $TempleInfoCopyWith<$Res> {
  factory _$$_TempleInfoCopyWith(
          _$_TempleInfo value, $Res Function(_$_TempleInfo) then) =
      __$$_TempleInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      String prefecture,
      String address,
      int distance,
      String encodedPoints,
      String knowledge,
      @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
          GeoPoint geoPoint,
      List<String> images});
}

/// @nodoc
class __$$_TempleInfoCopyWithImpl<$Res> extends _$TempleInfoCopyWithImpl<$Res>
    implements _$$_TempleInfoCopyWith<$Res> {
  __$$_TempleInfoCopyWithImpl(
      _$_TempleInfo _value, $Res Function(_$_TempleInfo) _then)
      : super(_value, (v) => _then(v as _$_TempleInfo));

  @override
  _$_TempleInfo get _value => super._value as _$_TempleInfo;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? prefecture = freezed,
    Object? address = freezed,
    Object? distance = freezed,
    Object? encodedPoints = freezed,
    Object? knowledge = freezed,
    Object? geoPoint = freezed,
    Object? images = freezed,
  }) {
    return _then(_$_TempleInfo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      prefecture: prefecture == freezed
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as int,
      encodedPoints: encodedPoints == freezed
          ? _value.encodedPoints
          : encodedPoints // ignore: cast_nullable_to_non_nullable
              as String,
      knowledge: knowledge == freezed
          ? _value.knowledge
          : knowledge // ignore: cast_nullable_to_non_nullable
              as String,
      geoPoint: geoPoint == freezed
          ? _value.geoPoint
          : geoPoint // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      images: images == freezed
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TempleInfo extends _TempleInfo {
  const _$_TempleInfo(
      {required this.id,
      required this.name,
      required this.prefecture,
      required this.address,
      required this.distance,
      required this.encodedPoints,
      this.knowledge = 'お寺の詳細情報',
      @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
          required this.geoPoint,
      final List<String> images = const []})
      : _images = images,
        super._();

  factory _$_TempleInfo.fromJson(Map<String, dynamic> json) =>
      _$$_TempleInfoFromJson(json);

// ID, お寺の番号
  @override
  final int id;
// 名前
  @override
  final String name;
// 都道府県
  @override
  final String prefecture;
// 住所
  @override
  final String address;
// 次のお寺までの距離
  @override
  final int distance;
// 次のお寺までの経路(エンコード文字列)
  @override
  final String encodedPoints;
// お寺のうんちく
  @override
  @JsonKey()
  final String knowledge;
// お寺の座標
  @override
  @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
  final GeoPoint geoPoint;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'TempleInfo(id: $id, name: $name, prefecture: $prefecture, address: $address, distance: $distance, encodedPoints: $encodedPoints, knowledge: $knowledge, geoPoint: $geoPoint, images: $images)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TempleInfo &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.prefecture, prefecture) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.distance, distance) &&
            const DeepCollectionEquality()
                .equals(other.encodedPoints, encodedPoints) &&
            const DeepCollectionEquality().equals(other.knowledge, knowledge) &&
            const DeepCollectionEquality().equals(other.geoPoint, geoPoint) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(prefecture),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(distance),
      const DeepCollectionEquality().hash(encodedPoints),
      const DeepCollectionEquality().hash(knowledge),
      const DeepCollectionEquality().hash(geoPoint),
      const DeepCollectionEquality().hash(_images));

  @JsonKey(ignore: true)
  @override
  _$$_TempleInfoCopyWith<_$_TempleInfo> get copyWith =>
      __$$_TempleInfoCopyWithImpl<_$_TempleInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TempleInfoToJson(
      this,
    );
  }
}

abstract class _TempleInfo extends TempleInfo {
  const factory _TempleInfo(
      {required final int id,
      required final String name,
      required final String prefecture,
      required final String address,
      required final int distance,
      required final String encodedPoints,
      final String knowledge,
      @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
          required final GeoPoint geoPoint,
      final List<String> images}) = _$_TempleInfo;
  const _TempleInfo._() : super._();

  factory _TempleInfo.fromJson(Map<String, dynamic> json) =
      _$_TempleInfo.fromJson;

  @override // ID, お寺の番号
  int get id;
  @override // 名前
  String get name;
  @override // 都道府県
  String get prefecture;
  @override // 住所
  String get address;
  @override // 次のお寺までの距離
  int get distance;
  @override // 次のお寺までの経路(エンコード文字列)
  String get encodedPoints;
  @override // お寺のうんちく
  String get knowledge;
  @override // お寺の座標
  @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson)
  GeoPoint get geoPoint;
  @override
  List<String> get images;
  @override
  @JsonKey(ignore: true)
  _$$_TempleInfoCopyWith<_$_TempleInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

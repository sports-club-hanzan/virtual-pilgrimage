// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'update_pilgrimage_progress_result.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UpdatePilgrimageProgressResult {
// お遍路の進捗更新結果の状態
  UpdatePilgrimageProgressResultStatus get status =>
      throw _privateConstructorUsedError; // 新たに到達した札所の番号一覧
  List<int> get reachedPilgrimageIdList =>
      throw _privateConstructorUsedError; // 現在、仮想的に移動している経路の緯度・経路のリスト
  List<LatLng> get virtualPolylineLatLngs =>
      throw _privateConstructorUsedError; // 現在の仮想的なユーザの緯度・軽度
  LatLng? get virtualPosition =>
      throw _privateConstructorUsedError; // ロジックによって更新されたときのユーザの情報
  VirtualPilgrimageUser? get updatedUser =>
      throw _privateConstructorUsedError; // ロジック実行時に発生したエラー
  Exception? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdatePilgrimageProgressResultCopyWith<UpdatePilgrimageProgressResult>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePilgrimageProgressResultCopyWith<$Res> {
  factory $UpdatePilgrimageProgressResultCopyWith(
          UpdatePilgrimageProgressResult value,
          $Res Function(UpdatePilgrimageProgressResult) then) =
      _$UpdatePilgrimageProgressResultCopyWithImpl<$Res>;
  $Res call(
      {UpdatePilgrimageProgressResultStatus status,
      List<int> reachedPilgrimageIdList,
      List<LatLng> virtualPolylineLatLngs,
      LatLng? virtualPosition,
      VirtualPilgrimageUser? updatedUser,
      Exception? error});

  $VirtualPilgrimageUserCopyWith<$Res>? get updatedUser;
}

/// @nodoc
class _$UpdatePilgrimageProgressResultCopyWithImpl<$Res>
    implements $UpdatePilgrimageProgressResultCopyWith<$Res> {
  _$UpdatePilgrimageProgressResultCopyWithImpl(this._value, this._then);

  final UpdatePilgrimageProgressResult _value;
  // ignore: unused_field
  final $Res Function(UpdatePilgrimageProgressResult) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? reachedPilgrimageIdList = freezed,
    Object? virtualPolylineLatLngs = freezed,
    Object? virtualPosition = freezed,
    Object? updatedUser = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdatePilgrimageProgressResultStatus,
      reachedPilgrimageIdList: reachedPilgrimageIdList == freezed
          ? _value.reachedPilgrimageIdList
          : reachedPilgrimageIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      virtualPolylineLatLngs: virtualPolylineLatLngs == freezed
          ? _value.virtualPolylineLatLngs
          : virtualPolylineLatLngs // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      virtualPosition: virtualPosition == freezed
          ? _value.virtualPosition
          : virtualPosition // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      updatedUser: updatedUser == freezed
          ? _value.updatedUser
          : updatedUser // ignore: cast_nullable_to_non_nullable
              as VirtualPilgrimageUser?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }

  @override
  $VirtualPilgrimageUserCopyWith<$Res>? get updatedUser {
    if (_value.updatedUser == null) {
      return null;
    }

    return $VirtualPilgrimageUserCopyWith<$Res>(_value.updatedUser!, (value) {
      return _then(_value.copyWith(updatedUser: value));
    });
  }
}

/// @nodoc
abstract class _$$_UpdatePilgrimageProgressResultCopyWith<$Res>
    implements $UpdatePilgrimageProgressResultCopyWith<$Res> {
  factory _$$_UpdatePilgrimageProgressResultCopyWith(
          _$_UpdatePilgrimageProgressResult value,
          $Res Function(_$_UpdatePilgrimageProgressResult) then) =
      __$$_UpdatePilgrimageProgressResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {UpdatePilgrimageProgressResultStatus status,
      List<int> reachedPilgrimageIdList,
      List<LatLng> virtualPolylineLatLngs,
      LatLng? virtualPosition,
      VirtualPilgrimageUser? updatedUser,
      Exception? error});

  @override
  $VirtualPilgrimageUserCopyWith<$Res>? get updatedUser;
}

/// @nodoc
class __$$_UpdatePilgrimageProgressResultCopyWithImpl<$Res>
    extends _$UpdatePilgrimageProgressResultCopyWithImpl<$Res>
    implements _$$_UpdatePilgrimageProgressResultCopyWith<$Res> {
  __$$_UpdatePilgrimageProgressResultCopyWithImpl(
      _$_UpdatePilgrimageProgressResult _value,
      $Res Function(_$_UpdatePilgrimageProgressResult) _then)
      : super(_value, (v) => _then(v as _$_UpdatePilgrimageProgressResult));

  @override
  _$_UpdatePilgrimageProgressResult get _value =>
      super._value as _$_UpdatePilgrimageProgressResult;

  @override
  $Res call({
    Object? status = freezed,
    Object? reachedPilgrimageIdList = freezed,
    Object? virtualPolylineLatLngs = freezed,
    Object? virtualPosition = freezed,
    Object? updatedUser = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_UpdatePilgrimageProgressResult(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdatePilgrimageProgressResultStatus,
      reachedPilgrimageIdList: reachedPilgrimageIdList == freezed
          ? _value._reachedPilgrimageIdList
          : reachedPilgrimageIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      virtualPolylineLatLngs: virtualPolylineLatLngs == freezed
          ? _value._virtualPolylineLatLngs
          : virtualPolylineLatLngs // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      virtualPosition: virtualPosition == freezed
          ? _value.virtualPosition
          : virtualPosition // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      updatedUser: updatedUser == freezed
          ? _value.updatedUser
          : updatedUser // ignore: cast_nullable_to_non_nullable
              as VirtualPilgrimageUser?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$_UpdatePilgrimageProgressResult
    extends _UpdatePilgrimageProgressResult {
  const _$_UpdatePilgrimageProgressResult(
      {required this.status,
      required final List<int> reachedPilgrimageIdList,
      final List<LatLng> virtualPolylineLatLngs = const [],
      this.virtualPosition,
      this.updatedUser,
      this.error})
      : _reachedPilgrimageIdList = reachedPilgrimageIdList,
        _virtualPolylineLatLngs = virtualPolylineLatLngs,
        super._();

// お遍路の進捗更新結果の状態
  @override
  final UpdatePilgrimageProgressResultStatus status;
// 新たに到達した札所の番号一覧
  final List<int> _reachedPilgrimageIdList;
// 新たに到達した札所の番号一覧
  @override
  List<int> get reachedPilgrimageIdList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reachedPilgrimageIdList);
  }

// 現在、仮想的に移動している経路の緯度・経路のリスト
  final List<LatLng> _virtualPolylineLatLngs;
// 現在、仮想的に移動している経路の緯度・経路のリスト
  @override
  @JsonKey()
  List<LatLng> get virtualPolylineLatLngs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_virtualPolylineLatLngs);
  }

// 現在の仮想的なユーザの緯度・軽度
  @override
  final LatLng? virtualPosition;
// ロジックによって更新されたときのユーザの情報
  @override
  final VirtualPilgrimageUser? updatedUser;
// ロジック実行時に発生したエラー
  @override
  final Exception? error;

  @override
  String toString() {
    return 'UpdatePilgrimageProgressResult(status: $status, reachedPilgrimageIdList: $reachedPilgrimageIdList, virtualPolylineLatLngs: $virtualPolylineLatLngs, virtualPosition: $virtualPosition, updatedUser: $updatedUser, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdatePilgrimageProgressResult &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(
                other._reachedPilgrimageIdList, _reachedPilgrimageIdList) &&
            const DeepCollectionEquality().equals(
                other._virtualPolylineLatLngs, _virtualPolylineLatLngs) &&
            const DeepCollectionEquality()
                .equals(other.virtualPosition, virtualPosition) &&
            const DeepCollectionEquality()
                .equals(other.updatedUser, updatedUser) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(_reachedPilgrimageIdList),
      const DeepCollectionEquality().hash(_virtualPolylineLatLngs),
      const DeepCollectionEquality().hash(virtualPosition),
      const DeepCollectionEquality().hash(updatedUser),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$_UpdatePilgrimageProgressResultCopyWith<_$_UpdatePilgrimageProgressResult>
      get copyWith => __$$_UpdatePilgrimageProgressResultCopyWithImpl<
          _$_UpdatePilgrimageProgressResult>(this, _$identity);
}

abstract class _UpdatePilgrimageProgressResult
    extends UpdatePilgrimageProgressResult {
  const factory _UpdatePilgrimageProgressResult(
      {required final UpdatePilgrimageProgressResultStatus status,
      required final List<int> reachedPilgrimageIdList,
      final List<LatLng> virtualPolylineLatLngs,
      final LatLng? virtualPosition,
      final VirtualPilgrimageUser? updatedUser,
      final Exception? error}) = _$_UpdatePilgrimageProgressResult;
  const _UpdatePilgrimageProgressResult._() : super._();

  @override // お遍路の進捗更新結果の状態
  UpdatePilgrimageProgressResultStatus get status;
  @override // 新たに到達した札所の番号一覧
  List<int> get reachedPilgrimageIdList;
  @override // 現在、仮想的に移動している経路の緯度・経路のリスト
  List<LatLng> get virtualPolylineLatLngs;
  @override // 現在の仮想的なユーザの緯度・軽度
  LatLng? get virtualPosition;
  @override // ロジックによって更新されたときのユーザの情報
  VirtualPilgrimageUser? get updatedUser;
  @override // ロジック実行時に発生したエラー
  Exception? get error;
  @override
  @JsonKey(ignore: true)
  _$$_UpdatePilgrimageProgressResultCopyWith<_$_UpdatePilgrimageProgressResult>
      get copyWith => throw _privateConstructorUsedError;
}

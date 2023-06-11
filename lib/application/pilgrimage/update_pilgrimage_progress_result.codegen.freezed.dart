// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$UpdatePilgrimageProgressResultCopyWithImpl<$Res,
          UpdatePilgrimageProgressResult>;
  @useResult
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
class _$UpdatePilgrimageProgressResultCopyWithImpl<$Res,
        $Val extends UpdatePilgrimageProgressResult>
    implements $UpdatePilgrimageProgressResultCopyWith<$Res> {
  _$UpdatePilgrimageProgressResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? reachedPilgrimageIdList = null,
    Object? virtualPolylineLatLngs = null,
    Object? virtualPosition = freezed,
    Object? updatedUser = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdatePilgrimageProgressResultStatus,
      reachedPilgrimageIdList: null == reachedPilgrimageIdList
          ? _value.reachedPilgrimageIdList
          : reachedPilgrimageIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      virtualPolylineLatLngs: null == virtualPolylineLatLngs
          ? _value.virtualPolylineLatLngs
          : virtualPolylineLatLngs // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      virtualPosition: freezed == virtualPosition
          ? _value.virtualPosition
          : virtualPosition // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      updatedUser: freezed == updatedUser
          ? _value.updatedUser
          : updatedUser // ignore: cast_nullable_to_non_nullable
              as VirtualPilgrimageUser?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VirtualPilgrimageUserCopyWith<$Res>? get updatedUser {
    if (_value.updatedUser == null) {
      return null;
    }

    return $VirtualPilgrimageUserCopyWith<$Res>(_value.updatedUser!, (value) {
      return _then(_value.copyWith(updatedUser: value) as $Val);
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
  @useResult
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
    extends _$UpdatePilgrimageProgressResultCopyWithImpl<$Res,
        _$_UpdatePilgrimageProgressResult>
    implements _$$_UpdatePilgrimageProgressResultCopyWith<$Res> {
  __$$_UpdatePilgrimageProgressResultCopyWithImpl(
      _$_UpdatePilgrimageProgressResult _value,
      $Res Function(_$_UpdatePilgrimageProgressResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? reachedPilgrimageIdList = null,
    Object? virtualPolylineLatLngs = null,
    Object? virtualPosition = freezed,
    Object? updatedUser = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_UpdatePilgrimageProgressResult(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdatePilgrimageProgressResultStatus,
      reachedPilgrimageIdList: null == reachedPilgrimageIdList
          ? _value._reachedPilgrimageIdList
          : reachedPilgrimageIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      virtualPolylineLatLngs: null == virtualPolylineLatLngs
          ? _value._virtualPolylineLatLngs
          : virtualPolylineLatLngs // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      virtualPosition: freezed == virtualPosition
          ? _value.virtualPosition
          : virtualPosition // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      updatedUser: freezed == updatedUser
          ? _value.updatedUser
          : updatedUser // ignore: cast_nullable_to_non_nullable
              as VirtualPilgrimageUser?,
      error: freezed == error
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
    if (_reachedPilgrimageIdList is EqualUnmodifiableListView)
      return _reachedPilgrimageIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reachedPilgrimageIdList);
  }

// 現在、仮想的に移動している経路の緯度・経路のリスト
  final List<LatLng> _virtualPolylineLatLngs;
// 現在、仮想的に移動している経路の緯度・経路のリスト
  @override
  @JsonKey()
  List<LatLng> get virtualPolylineLatLngs {
    if (_virtualPolylineLatLngs is EqualUnmodifiableListView)
      return _virtualPolylineLatLngs;
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
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
                other._reachedPilgrimageIdList, _reachedPilgrimageIdList) &&
            const DeepCollectionEquality().equals(
                other._virtualPolylineLatLngs, _virtualPolylineLatLngs) &&
            (identical(other.virtualPosition, virtualPosition) ||
                other.virtualPosition == virtualPosition) &&
            (identical(other.updatedUser, updatedUser) ||
                other.updatedUser == updatedUser) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_reachedPilgrimageIdList),
      const DeepCollectionEquality().hash(_virtualPolylineLatLngs),
      virtualPosition,
      updatedUser,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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

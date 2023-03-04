// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'temple_state.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TempleState {
  List<TempleInfo> get temples => throw _privateConstructorUsedError;
  ScrollController get scrollController => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempleStateCopyWith<TempleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempleStateCopyWith<$Res> {
  factory $TempleStateCopyWith(
          TempleState value, $Res Function(TempleState) then) =
      _$TempleStateCopyWithImpl<$Res, TempleState>;
  @useResult
  $Res call(
      {List<TempleInfo> temples,
      ScrollController scrollController,
      bool loading});
}

/// @nodoc
class _$TempleStateCopyWithImpl<$Res, $Val extends TempleState>
    implements $TempleStateCopyWith<$Res> {
  _$TempleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temples = null,
    Object? scrollController = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      temples: null == temples
          ? _value.temples
          : temples // ignore: cast_nullable_to_non_nullable
              as List<TempleInfo>,
      scrollController: null == scrollController
          ? _value.scrollController
          : scrollController // ignore: cast_nullable_to_non_nullable
              as ScrollController,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TempleStateCopyWith<$Res>
    implements $TempleStateCopyWith<$Res> {
  factory _$$_TempleStateCopyWith(
          _$_TempleState value, $Res Function(_$_TempleState) then) =
      __$$_TempleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TempleInfo> temples,
      ScrollController scrollController,
      bool loading});
}

/// @nodoc
class __$$_TempleStateCopyWithImpl<$Res>
    extends _$TempleStateCopyWithImpl<$Res, _$_TempleState>
    implements _$$_TempleStateCopyWith<$Res> {
  __$$_TempleStateCopyWithImpl(
      _$_TempleState _value, $Res Function(_$_TempleState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temples = null,
    Object? scrollController = null,
    Object? loading = null,
  }) {
    return _then(_$_TempleState(
      temples: null == temples
          ? _value._temples
          : temples // ignore: cast_nullable_to_non_nullable
              as List<TempleInfo>,
      scrollController: null == scrollController
          ? _value.scrollController
          : scrollController // ignore: cast_nullable_to_non_nullable
              as ScrollController,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TempleState extends _TempleState {
  const _$_TempleState(
      {final List<TempleInfo> temples = const [],
      required this.scrollController,
      this.loading = false})
      : _temples = temples,
        super._();

  final List<TempleInfo> _temples;
  @override
  @JsonKey()
  List<TempleInfo> get temples {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_temples);
  }

  @override
  final ScrollController scrollController;
  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'TempleState(temples: $temples, scrollController: $scrollController, loading: $loading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TempleState &&
            const DeepCollectionEquality().equals(other._temples, _temples) &&
            (identical(other.scrollController, scrollController) ||
                other.scrollController == scrollController) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_temples), scrollController, loading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TempleStateCopyWith<_$_TempleState> get copyWith =>
      __$$_TempleStateCopyWithImpl<_$_TempleState>(this, _$identity);
}

abstract class _TempleState extends TempleState {
  const factory _TempleState(
      {final List<TempleInfo> temples,
      required final ScrollController scrollController,
      final bool loading}) = _$_TempleState;
  const _TempleState._() : super._();

  @override
  List<TempleInfo> get temples;
  @override
  ScrollController get scrollController;
  @override
  bool get loading;
  @override
  @JsonKey(ignore: true)
  _$$_TempleStateCopyWith<_$_TempleState> get copyWith =>
      throw _privateConstructorUsedError;
}

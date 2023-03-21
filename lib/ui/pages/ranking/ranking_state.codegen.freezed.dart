// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_state.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RankingState {
  ScrollController get scrollController => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RankingStateCopyWith<RankingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RankingStateCopyWith<$Res> {
  factory $RankingStateCopyWith(
          RankingState value, $Res Function(RankingState) then) =
      _$RankingStateCopyWithImpl<$Res, RankingState>;
  @useResult
  $Res call({ScrollController scrollController});
}

/// @nodoc
class _$RankingStateCopyWithImpl<$Res, $Val extends RankingState>
    implements $RankingStateCopyWith<$Res> {
  _$RankingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scrollController = null,
  }) {
    return _then(_value.copyWith(
      scrollController: null == scrollController
          ? _value.scrollController
          : scrollController // ignore: cast_nullable_to_non_nullable
              as ScrollController,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RankingStateCopyWith<$Res>
    implements $RankingStateCopyWith<$Res> {
  factory _$$_RankingStateCopyWith(
          _$_RankingState value, $Res Function(_$_RankingState) then) =
      __$$_RankingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ScrollController scrollController});
}

/// @nodoc
class __$$_RankingStateCopyWithImpl<$Res>
    extends _$RankingStateCopyWithImpl<$Res, _$_RankingState>
    implements _$$_RankingStateCopyWith<$Res> {
  __$$_RankingStateCopyWithImpl(
      _$_RankingState _value, $Res Function(_$_RankingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scrollController = null,
  }) {
    return _then(_$_RankingState(
      scrollController: null == scrollController
          ? _value.scrollController
          : scrollController // ignore: cast_nullable_to_non_nullable
              as ScrollController,
    ));
  }
}

/// @nodoc

class _$_RankingState extends _RankingState {
  _$_RankingState({required this.scrollController}) : super._();

  @override
  final ScrollController scrollController;

  @override
  String toString() {
    return 'RankingState(scrollController: $scrollController)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RankingState &&
            (identical(other.scrollController, scrollController) ||
                other.scrollController == scrollController));
  }

  @override
  int get hashCode => Object.hash(runtimeType, scrollController);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RankingStateCopyWith<_$_RankingState> get copyWith =>
      __$$_RankingStateCopyWithImpl<_$_RankingState>(this, _$identity);
}

abstract class _RankingState extends RankingState {
  factory _RankingState({required final ScrollController scrollController}) =
      _$_RankingState;
  _RankingState._() : super._();

  @override
  ScrollController get scrollController;
  @override
  @JsonKey(ignore: true)
  _$$_RankingStateCopyWith<_$_RankingState> get copyWith =>
      throw _privateConstructorUsedError;
}

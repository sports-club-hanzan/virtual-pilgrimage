// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'form_model.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FormModel {
  Validator get validator => throw _privateConstructorUsedError;
  TextEditingController get controller => throw _privateConstructorUsedError;
  FocusNode get focusNode => throw _privateConstructorUsedError;
  bool get hasEdited => throw _privateConstructorUsedError;
  List<String> get externalErrors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FormModelCopyWith<FormModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormModelCopyWith<$Res> {
  factory $FormModelCopyWith(FormModel value, $Res Function(FormModel) then) =
      _$FormModelCopyWithImpl<$Res, FormModel>;
  @useResult
  $Res call(
      {Validator validator,
      TextEditingController controller,
      FocusNode focusNode,
      bool hasEdited,
      List<String> externalErrors});
}

/// @nodoc
class _$FormModelCopyWithImpl<$Res, $Val extends FormModel>
    implements $FormModelCopyWith<$Res> {
  _$FormModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? validator = null,
    Object? controller = null,
    Object? focusNode = null,
    Object? hasEdited = null,
    Object? externalErrors = null,
  }) {
    return _then(_value.copyWith(
      validator: null == validator
          ? _value.validator
          : validator // ignore: cast_nullable_to_non_nullable
              as Validator,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      focusNode: null == focusNode
          ? _value.focusNode
          : focusNode // ignore: cast_nullable_to_non_nullable
              as FocusNode,
      hasEdited: null == hasEdited
          ? _value.hasEdited
          : hasEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      externalErrors: null == externalErrors
          ? _value.externalErrors
          : externalErrors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FormModelCopyWith<$Res> implements $FormModelCopyWith<$Res> {
  factory _$$_FormModelCopyWith(
          _$_FormModel value, $Res Function(_$_FormModel) then) =
      __$$_FormModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Validator validator,
      TextEditingController controller,
      FocusNode focusNode,
      bool hasEdited,
      List<String> externalErrors});
}

/// @nodoc
class __$$_FormModelCopyWithImpl<$Res>
    extends _$FormModelCopyWithImpl<$Res, _$_FormModel>
    implements _$$_FormModelCopyWith<$Res> {
  __$$_FormModelCopyWithImpl(
      _$_FormModel _value, $Res Function(_$_FormModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? validator = null,
    Object? controller = null,
    Object? focusNode = null,
    Object? hasEdited = null,
    Object? externalErrors = null,
  }) {
    return _then(_$_FormModel(
      validator: null == validator
          ? _value.validator
          : validator // ignore: cast_nullable_to_non_nullable
              as Validator,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      focusNode: null == focusNode
          ? _value.focusNode
          : focusNode // ignore: cast_nullable_to_non_nullable
              as FocusNode,
      hasEdited: null == hasEdited
          ? _value.hasEdited
          : hasEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      externalErrors: null == externalErrors
          ? _value._externalErrors
          : externalErrors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_FormModel extends _FormModel {
  _$_FormModel(
      {required this.validator,
      required this.controller,
      required this.focusNode,
      this.hasEdited = false,
      final List<String> externalErrors = const []})
      : _externalErrors = externalErrors,
        super._();

  @override
  final Validator validator;
  @override
  final TextEditingController controller;
  @override
  final FocusNode focusNode;
  @override
  @JsonKey()
  final bool hasEdited;
  final List<String> _externalErrors;
  @override
  @JsonKey()
  List<String> get externalErrors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_externalErrors);
  }

  @override
  String toString() {
    return 'FormModel(validator: $validator, controller: $controller, focusNode: $focusNode, hasEdited: $hasEdited, externalErrors: $externalErrors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FormModel &&
            (identical(other.validator, validator) ||
                other.validator == validator) &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(other.focusNode, focusNode) ||
                other.focusNode == focusNode) &&
            (identical(other.hasEdited, hasEdited) ||
                other.hasEdited == hasEdited) &&
            const DeepCollectionEquality()
                .equals(other._externalErrors, _externalErrors));
  }

  @override
  int get hashCode => Object.hash(runtimeType, validator, controller, focusNode,
      hasEdited, const DeepCollectionEquality().hash(_externalErrors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FormModelCopyWith<_$_FormModel> get copyWith =>
      __$$_FormModelCopyWithImpl<_$_FormModel>(this, _$identity);
}

abstract class _FormModel extends FormModel {
  factory _FormModel(
      {required final Validator validator,
      required final TextEditingController controller,
      required final FocusNode focusNode,
      final bool hasEdited,
      final List<String> externalErrors}) = _$_FormModel;
  _FormModel._() : super._();

  @override
  Validator get validator;
  @override
  TextEditingController get controller;
  @override
  FocusNode get focusNode;
  @override
  bool get hasEdited;
  @override
  List<String> get externalErrors;
  @override
  @JsonKey(ignore: true)
  _$$_FormModelCopyWith<_$_FormModel> get copyWith =>
      throw _privateConstructorUsedError;
}

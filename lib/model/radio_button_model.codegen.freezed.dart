// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'radio_button_model.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RadioButtonModel<T> {
// TODO(s14t284): focusNode がラジオボタンにおいて複数必要なのか調べる
  List<FocusNode> get focusNodes => throw _privateConstructorUsedError;
  List<String> get titles => throw _privateConstructorUsedError;
  List<T> get values => throw _privateConstructorUsedError;
  T get selectedValue => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RadioButtonModelCopyWith<T, RadioButtonModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RadioButtonModelCopyWith<T, $Res> {
  factory $RadioButtonModelCopyWith(
          RadioButtonModel<T> value, $Res Function(RadioButtonModel<T>) then) =
      _$RadioButtonModelCopyWithImpl<T, $Res>;
  $Res call(
      {List<FocusNode> focusNodes,
      List<String> titles,
      List<T> values,
      T selectedValue});
}

/// @nodoc
class _$RadioButtonModelCopyWithImpl<T, $Res>
    implements $RadioButtonModelCopyWith<T, $Res> {
  _$RadioButtonModelCopyWithImpl(this._value, this._then);

  final RadioButtonModel<T> _value;
  // ignore: unused_field
  final $Res Function(RadioButtonModel<T>) _then;

  @override
  $Res call({
    Object? focusNodes = freezed,
    Object? titles = freezed,
    Object? values = freezed,
    Object? selectedValue = freezed,
  }) {
    return _then(_value.copyWith(
      focusNodes: focusNodes == freezed
          ? _value.focusNodes
          : focusNodes // ignore: cast_nullable_to_non_nullable
              as List<FocusNode>,
      titles: titles == freezed
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      values: values == freezed
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<T>,
      selectedValue: selectedValue == freezed
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
abstract class _$$_RadioButtonModelCopyWith<T, $Res>
    implements $RadioButtonModelCopyWith<T, $Res> {
  factory _$$_RadioButtonModelCopyWith(_$_RadioButtonModel<T> value,
          $Res Function(_$_RadioButtonModel<T>) then) =
      __$$_RadioButtonModelCopyWithImpl<T, $Res>;
  @override
  $Res call(
      {List<FocusNode> focusNodes,
      List<String> titles,
      List<T> values,
      T selectedValue});
}

/// @nodoc
class __$$_RadioButtonModelCopyWithImpl<T, $Res>
    extends _$RadioButtonModelCopyWithImpl<T, $Res>
    implements _$$_RadioButtonModelCopyWith<T, $Res> {
  __$$_RadioButtonModelCopyWithImpl(_$_RadioButtonModel<T> _value,
      $Res Function(_$_RadioButtonModel<T>) _then)
      : super(_value, (v) => _then(v as _$_RadioButtonModel<T>));

  @override
  _$_RadioButtonModel<T> get _value => super._value as _$_RadioButtonModel<T>;

  @override
  $Res call({
    Object? focusNodes = freezed,
    Object? titles = freezed,
    Object? values = freezed,
    Object? selectedValue = freezed,
  }) {
    return _then(_$_RadioButtonModel<T>(
      focusNodes: focusNodes == freezed
          ? _value._focusNodes
          : focusNodes // ignore: cast_nullable_to_non_nullable
              as List<FocusNode>,
      titles: titles == freezed
          ? _value._titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      values: values == freezed
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<T>,
      selectedValue: selectedValue == freezed
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_RadioButtonModel<T> extends _RadioButtonModel<T> {
  _$_RadioButtonModel(
      {required final List<FocusNode> focusNodes,
      required final List<String> titles,
      required final List<T> values,
      required this.selectedValue})
      : _focusNodes = focusNodes,
        _titles = titles,
        _values = values,
        super._();

// TODO(s14t284): focusNode がラジオボタンにおいて複数必要なのか調べる
  final List<FocusNode> _focusNodes;
// TODO(s14t284): focusNode がラジオボタンにおいて複数必要なのか調べる
  @override
  List<FocusNode> get focusNodes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_focusNodes);
  }

  final List<String> _titles;
  @override
  List<String> get titles {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_titles);
  }

  final List<T> _values;
  @override
  List<T> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  final T selectedValue;

  @override
  String toString() {
    return 'RadioButtonModel<$T>(focusNodes: $focusNodes, titles: $titles, values: $values, selectedValue: $selectedValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RadioButtonModel<T> &&
            const DeepCollectionEquality()
                .equals(other._focusNodes, _focusNodes) &&
            const DeepCollectionEquality().equals(other._titles, _titles) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            const DeepCollectionEquality()
                .equals(other.selectedValue, selectedValue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_focusNodes),
      const DeepCollectionEquality().hash(_titles),
      const DeepCollectionEquality().hash(_values),
      const DeepCollectionEquality().hash(selectedValue));

  @JsonKey(ignore: true)
  @override
  _$$_RadioButtonModelCopyWith<T, _$_RadioButtonModel<T>> get copyWith =>
      __$$_RadioButtonModelCopyWithImpl<T, _$_RadioButtonModel<T>>(
          this, _$identity);
}

abstract class _RadioButtonModel<T> extends RadioButtonModel<T> {
  factory _RadioButtonModel(
      {required final List<FocusNode> focusNodes,
      required final List<String> titles,
      required final List<T> values,
      required final T selectedValue}) = _$_RadioButtonModel<T>;
  _RadioButtonModel._() : super._();

  @override // TODO(s14t284): focusNode がラジオボタンにおいて複数必要なのか調べる
  List<FocusNode> get focusNodes;
  @override
  List<String> get titles;
  @override
  List<T> get values;
  @override
  T get selectedValue;
  @override
  @JsonKey(ignore: true)
  _$$_RadioButtonModelCopyWith<T, _$_RadioButtonModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'radio_button_model.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ColorModel {
  Color get lightColor => throw _privateConstructorUsedError;
  Color get darkColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ColorModelCopyWith<ColorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorModelCopyWith<$Res> {
  factory $ColorModelCopyWith(
          ColorModel value, $Res Function(ColorModel) then) =
      _$ColorModelCopyWithImpl<$Res, ColorModel>;
  @useResult
  $Res call({Color lightColor, Color darkColor});
}

/// @nodoc
class _$ColorModelCopyWithImpl<$Res, $Val extends ColorModel>
    implements $ColorModelCopyWith<$Res> {
  _$ColorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lightColor = null,
    Object? darkColor = null,
  }) {
    return _then(_value.copyWith(
      lightColor: null == lightColor
          ? _value.lightColor
          : lightColor // ignore: cast_nullable_to_non_nullable
              as Color,
      darkColor: null == darkColor
          ? _value.darkColor
          : darkColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ColorModelCopyWith<$Res>
    implements $ColorModelCopyWith<$Res> {
  factory _$$_ColorModelCopyWith(
          _$_ColorModel value, $Res Function(_$_ColorModel) then) =
      __$$_ColorModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Color lightColor, Color darkColor});
}

/// @nodoc
class __$$_ColorModelCopyWithImpl<$Res>
    extends _$ColorModelCopyWithImpl<$Res, _$_ColorModel>
    implements _$$_ColorModelCopyWith<$Res> {
  __$$_ColorModelCopyWithImpl(
      _$_ColorModel _value, $Res Function(_$_ColorModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lightColor = null,
    Object? darkColor = null,
  }) {
    return _then(_$_ColorModel(
      lightColor: null == lightColor
          ? _value.lightColor
          : lightColor // ignore: cast_nullable_to_non_nullable
              as Color,
      darkColor: null == darkColor
          ? _value.darkColor
          : darkColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$_ColorModel extends _ColorModel {
  _$_ColorModel({required this.lightColor, required this.darkColor})
      : super._();

  @override
  final Color lightColor;
  @override
  final Color darkColor;

  @override
  String toString() {
    return 'ColorModel(lightColor: $lightColor, darkColor: $darkColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ColorModel &&
            (identical(other.lightColor, lightColor) ||
                other.lightColor == lightColor) &&
            (identical(other.darkColor, darkColor) ||
                other.darkColor == darkColor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lightColor, darkColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ColorModelCopyWith<_$_ColorModel> get copyWith =>
      __$$_ColorModelCopyWithImpl<_$_ColorModel>(this, _$identity);
}

abstract class _ColorModel extends ColorModel {
  factory _ColorModel(
      {required final Color lightColor,
      required final Color darkColor}) = _$_ColorModel;
  _ColorModel._() : super._();

  @override
  Color get lightColor;
  @override
  Color get darkColor;
  @override
  @JsonKey(ignore: true)
  _$$_ColorModelCopyWith<_$_ColorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RadioButtonModel<T> {
// TODO(s14t284): focusNode がラジオボタンにおいて複数必要なのか調べる
  List<FocusNode> get focusNodes => throw _privateConstructorUsedError;
  List<String> get titles => throw _privateConstructorUsedError;
  List<T> get values => throw _privateConstructorUsedError;
  T get selectedValue => throw _privateConstructorUsedError;
  List<ColorModel> get colors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RadioButtonModelCopyWith<T, RadioButtonModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RadioButtonModelCopyWith<T, $Res> {
  factory $RadioButtonModelCopyWith(
          RadioButtonModel<T> value, $Res Function(RadioButtonModel<T>) then) =
      _$RadioButtonModelCopyWithImpl<T, $Res, RadioButtonModel<T>>;
  @useResult
  $Res call(
      {List<FocusNode> focusNodes,
      List<String> titles,
      List<T> values,
      T selectedValue,
      List<ColorModel> colors});
}

/// @nodoc
class _$RadioButtonModelCopyWithImpl<T, $Res, $Val extends RadioButtonModel<T>>
    implements $RadioButtonModelCopyWith<T, $Res> {
  _$RadioButtonModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focusNodes = null,
    Object? titles = null,
    Object? values = null,
    Object? selectedValue = freezed,
    Object? colors = null,
  }) {
    return _then(_value.copyWith(
      focusNodes: null == focusNodes
          ? _value.focusNodes
          : focusNodes // ignore: cast_nullable_to_non_nullable
              as List<FocusNode>,
      titles: null == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<T>,
      selectedValue: freezed == selectedValue
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as T,
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<ColorModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RadioButtonModelCopyWith<T, $Res>
    implements $RadioButtonModelCopyWith<T, $Res> {
  factory _$$_RadioButtonModelCopyWith(_$_RadioButtonModel<T> value,
          $Res Function(_$_RadioButtonModel<T>) then) =
      __$$_RadioButtonModelCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {List<FocusNode> focusNodes,
      List<String> titles,
      List<T> values,
      T selectedValue,
      List<ColorModel> colors});
}

/// @nodoc
class __$$_RadioButtonModelCopyWithImpl<T, $Res>
    extends _$RadioButtonModelCopyWithImpl<T, $Res, _$_RadioButtonModel<T>>
    implements _$$_RadioButtonModelCopyWith<T, $Res> {
  __$$_RadioButtonModelCopyWithImpl(_$_RadioButtonModel<T> _value,
      $Res Function(_$_RadioButtonModel<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focusNodes = null,
    Object? titles = null,
    Object? values = null,
    Object? selectedValue = freezed,
    Object? colors = null,
  }) {
    return _then(_$_RadioButtonModel<T>(
      focusNodes: null == focusNodes
          ? _value._focusNodes
          : focusNodes // ignore: cast_nullable_to_non_nullable
              as List<FocusNode>,
      titles: null == titles
          ? _value._titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<T>,
      selectedValue: freezed == selectedValue
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as T,
      colors: null == colors
          ? _value._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<ColorModel>,
    ));
  }
}

/// @nodoc

class _$_RadioButtonModel<T> extends _RadioButtonModel<T> {
  _$_RadioButtonModel(
      {required final List<FocusNode> focusNodes,
      required final List<String> titles,
      required final List<T> values,
      required this.selectedValue,
      final List<ColorModel> colors = const []})
      : _focusNodes = focusNodes,
        _titles = titles,
        _values = values,
        _colors = colors,
        super._();

// TODO(s14t284): focusNode がラジオボタンにおいて複数必要なのか調べる
  final List<FocusNode> _focusNodes;
// TODO(s14t284): focusNode がラジオボタンにおいて複数必要なのか調べる
  @override
  List<FocusNode> get focusNodes {
    if (_focusNodes is EqualUnmodifiableListView) return _focusNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_focusNodes);
  }

  final List<String> _titles;
  @override
  List<String> get titles {
    if (_titles is EqualUnmodifiableListView) return _titles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_titles);
  }

  final List<T> _values;
  @override
  List<T> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  final T selectedValue;
  final List<ColorModel> _colors;
  @override
  @JsonKey()
  List<ColorModel> get colors {
    if (_colors is EqualUnmodifiableListView) return _colors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_colors);
  }

  @override
  String toString() {
    return 'RadioButtonModel<$T>(focusNodes: $focusNodes, titles: $titles, values: $values, selectedValue: $selectedValue, colors: $colors)';
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
                .equals(other.selectedValue, selectedValue) &&
            const DeepCollectionEquality().equals(other._colors, _colors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_focusNodes),
      const DeepCollectionEquality().hash(_titles),
      const DeepCollectionEquality().hash(_values),
      const DeepCollectionEquality().hash(selectedValue),
      const DeepCollectionEquality().hash(_colors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RadioButtonModelCopyWith<T, _$_RadioButtonModel<T>> get copyWith =>
      __$$_RadioButtonModelCopyWithImpl<T, _$_RadioButtonModel<T>>(
          this, _$identity);
}

abstract class _RadioButtonModel<T> extends RadioButtonModel<T> {
  factory _RadioButtonModel(
      {required final List<FocusNode> focusNodes,
      required final List<String> titles,
      required final List<T> values,
      required final T selectedValue,
      final List<ColorModel> colors}) = _$_RadioButtonModel<T>;
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
  List<ColorModel> get colors;
  @override
  @JsonKey(ignore: true)
  _$$_RadioButtonModelCopyWith<T, _$_RadioButtonModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

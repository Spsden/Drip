// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drip_home_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DripHomePage _$DripHomePageFromJson(Map<String, dynamic> json) {
  return _DripHomePage.fromJson(json);
}

/// @nodoc
mixin _$DripHomePage {
  List<Output>? get output => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DripHomePageCopyWith<DripHomePage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DripHomePageCopyWith<$Res> {
  factory $DripHomePageCopyWith(
          DripHomePage value, $Res Function(DripHomePage) then) =
      _$DripHomePageCopyWithImpl<$Res, DripHomePage>;
  @useResult
  $Res call({List<Output>? output});
}

/// @nodoc
class _$DripHomePageCopyWithImpl<$Res, $Val extends DripHomePage>
    implements $DripHomePageCopyWith<$Res> {
  _$DripHomePageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? output = freezed,
  }) {
    return _then(_value.copyWith(
      output: freezed == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as List<Output>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DripHomePageImplCopyWith<$Res>
    implements $DripHomePageCopyWith<$Res> {
  factory _$$DripHomePageImplCopyWith(
          _$DripHomePageImpl value, $Res Function(_$DripHomePageImpl) then) =
      __$$DripHomePageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Output>? output});
}

/// @nodoc
class __$$DripHomePageImplCopyWithImpl<$Res>
    extends _$DripHomePageCopyWithImpl<$Res, _$DripHomePageImpl>
    implements _$$DripHomePageImplCopyWith<$Res> {
  __$$DripHomePageImplCopyWithImpl(
      _$DripHomePageImpl _value, $Res Function(_$DripHomePageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? output = freezed,
  }) {
    return _then(_$DripHomePageImpl(
      output: freezed == output
          ? _value._output
          : output // ignore: cast_nullable_to_non_nullable
              as List<Output>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DripHomePageImpl implements _DripHomePage {
  _$DripHomePageImpl({final List<Output>? output}) : _output = output;

  factory _$DripHomePageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DripHomePageImplFromJson(json);

  final List<Output>? _output;
  @override
  List<Output>? get output {
    final value = _output;
    if (value == null) return null;
    if (_output is EqualUnmodifiableListView) return _output;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DripHomePage(output: $output)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DripHomePageImpl &&
            const DeepCollectionEquality().equals(other._output, _output));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_output));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DripHomePageImplCopyWith<_$DripHomePageImpl> get copyWith =>
      __$$DripHomePageImplCopyWithImpl<_$DripHomePageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DripHomePageImplToJson(
      this,
    );
  }
}

abstract class _DripHomePage implements DripHomePage {
  factory _DripHomePage({final List<Output>? output}) = _$DripHomePageImpl;

  factory _DripHomePage.fromJson(Map<String, dynamic> json) =
      _$DripHomePageImpl.fromJson;

  @override
  List<Output>? get output;
  @override
  @JsonKey(ignore: true)
  _$$DripHomePageImplCopyWith<_$DripHomePageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

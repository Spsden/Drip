// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drip_search_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DripSearchResults _$DripSearchResultsFromJson(Map<String, dynamic> json) {
  return _DripSearchResults.fromJson(json);
}

/// @nodoc
mixin _$DripSearchResults {
  String? get title => throw _privateConstructorUsedError;
  List<Item>? get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DripSearchResultsCopyWith<DripSearchResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DripSearchResultsCopyWith<$Res> {
  factory $DripSearchResultsCopyWith(
          DripSearchResults value, $Res Function(DripSearchResults) then) =
      _$DripSearchResultsCopyWithImpl<$Res, DripSearchResults>;
  @useResult
  $Res call({String? title, List<Item>? items});
}

/// @nodoc
class _$DripSearchResultsCopyWithImpl<$Res, $Val extends DripSearchResults>
    implements $DripSearchResultsCopyWith<$Res> {
  _$DripSearchResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DripSearchResultsImplCopyWith<$Res>
    implements $DripSearchResultsCopyWith<$Res> {
  factory _$$DripSearchResultsImplCopyWith(_$DripSearchResultsImpl value,
          $Res Function(_$DripSearchResultsImpl) then) =
      __$$DripSearchResultsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, List<Item>? items});
}

/// @nodoc
class __$$DripSearchResultsImplCopyWithImpl<$Res>
    extends _$DripSearchResultsCopyWithImpl<$Res, _$DripSearchResultsImpl>
    implements _$$DripSearchResultsImplCopyWith<$Res> {
  __$$DripSearchResultsImplCopyWithImpl(_$DripSearchResultsImpl _value,
      $Res Function(_$DripSearchResultsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? items = freezed,
  }) {
    return _then(_$DripSearchResultsImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DripSearchResultsImpl implements _DripSearchResults {
  _$DripSearchResultsImpl({this.title, final List<Item>? items})
      : _items = items;

  factory _$DripSearchResultsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DripSearchResultsImplFromJson(json);

  @override
  final String? title;
  final List<Item>? _items;
  @override
  List<Item>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DripSearchResults(title: $title, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DripSearchResultsImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DripSearchResultsImplCopyWith<_$DripSearchResultsImpl> get copyWith =>
      __$$DripSearchResultsImplCopyWithImpl<_$DripSearchResultsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DripSearchResultsImplToJson(
      this,
    );
  }
}

abstract class _DripSearchResults implements DripSearchResults {
  factory _DripSearchResults({final String? title, final List<Item>? items}) =
      _$DripSearchResultsImpl;

  factory _DripSearchResults.fromJson(Map<String, dynamic> json) =
      _$DripSearchResultsImpl.fromJson;

  @override
  String? get title;
  @override
  List<Item>? get items;
  @override
  @JsonKey(ignore: true)
  _$$DripSearchResultsImplCopyWith<_$DripSearchResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Content _$ContentFromJson(Map<String, dynamic> json) {
  return _Content.fromJson(json);
}

/// @nodoc
mixin _$Content {
  String? get title => throw _privateConstructorUsedError;
  String? get videoId => throw _privateConstructorUsedError;
  List<Artist>? get artists => throw _privateConstructorUsedError;
  List<Thumbnail>? get thumbnails => throw _privateConstructorUsedError;
  bool? get isExplicit => throw _privateConstructorUsedError;
  Album? get album => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get playlistId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContentCopyWith<Content> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentCopyWith<$Res> {
  factory $ContentCopyWith(Content value, $Res Function(Content) then) =
      _$ContentCopyWithImpl<$Res, Content>;
  @useResult
  $Res call(
      {String? title,
      String? videoId,
      List<Artist>? artists,
      List<Thumbnail>? thumbnails,
      bool? isExplicit,
      Album? album,
      String? description,
      String? playlistId});

  $AlbumCopyWith<$Res>? get album;
}

/// @nodoc
class _$ContentCopyWithImpl<$Res, $Val extends Content>
    implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? videoId = freezed,
    Object? artists = freezed,
    Object? thumbnails = freezed,
    Object? isExplicit = freezed,
    Object? album = freezed,
    Object? description = freezed,
    Object? playlistId = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      videoId: freezed == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String?,
      artists: freezed == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<Artist>?,
      thumbnails: freezed == thumbnails
          ? _value.thumbnails
          : thumbnails // ignore: cast_nullable_to_non_nullable
              as List<Thumbnail>?,
      isExplicit: freezed == isExplicit
          ? _value.isExplicit
          : isExplicit // ignore: cast_nullable_to_non_nullable
              as bool?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as Album?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      playlistId: freezed == playlistId
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AlbumCopyWith<$Res>? get album {
    if (_value.album == null) {
      return null;
    }

    return $AlbumCopyWith<$Res>(_value.album!, (value) {
      return _then(_value.copyWith(album: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? videoId,
      List<Artist>? artists,
      List<Thumbnail>? thumbnails,
      bool? isExplicit,
      Album? album,
      String? description,
      String? playlistId});

  @override
  $AlbumCopyWith<$Res>? get album;
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$ContentCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? videoId = freezed,
    Object? artists = freezed,
    Object? thumbnails = freezed,
    Object? isExplicit = freezed,
    Object? album = freezed,
    Object? description = freezed,
    Object? playlistId = freezed,
  }) {
    return _then(_$ContentImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      videoId: freezed == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String?,
      artists: freezed == artists
          ? _value._artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<Artist>?,
      thumbnails: freezed == thumbnails
          ? _value._thumbnails
          : thumbnails // ignore: cast_nullable_to_non_nullable
              as List<Thumbnail>?,
      isExplicit: freezed == isExplicit
          ? _value.isExplicit
          : isExplicit // ignore: cast_nullable_to_non_nullable
              as bool?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as Album?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      playlistId: freezed == playlistId
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentImpl implements _Content {
  _$ContentImpl(
      {this.title,
      this.videoId,
      final List<Artist>? artists,
      final List<Thumbnail>? thumbnails,
      this.isExplicit,
      this.album,
      this.description,
      this.playlistId})
      : _artists = artists,
        _thumbnails = thumbnails;

  factory _$ContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentImplFromJson(json);

  @override
  final String? title;
  @override
  final String? videoId;
  final List<Artist>? _artists;
  @override
  List<Artist>? get artists {
    final value = _artists;
    if (value == null) return null;
    if (_artists is EqualUnmodifiableListView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Thumbnail>? _thumbnails;
  @override
  List<Thumbnail>? get thumbnails {
    final value = _thumbnails;
    if (value == null) return null;
    if (_thumbnails is EqualUnmodifiableListView) return _thumbnails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isExplicit;
  @override
  final Album? album;
  @override
  final String? description;
  @override
  final String? playlistId;

  @override
  String toString() {
    return 'Content(title: $title, videoId: $videoId, artists: $artists, thumbnails: $thumbnails, isExplicit: $isExplicit, album: $album, description: $description, playlistId: $playlistId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            const DeepCollectionEquality()
                .equals(other._thumbnails, _thumbnails) &&
            (identical(other.isExplicit, isExplicit) ||
                other.isExplicit == isExplicit) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.playlistId, playlistId) ||
                other.playlistId == playlistId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      videoId,
      const DeepCollectionEquality().hash(_artists),
      const DeepCollectionEquality().hash(_thumbnails),
      isExplicit,
      album,
      description,
      playlistId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentImplToJson(
      this,
    );
  }
}

abstract class _Content implements Content {
  factory _Content(
      {final String? title,
      final String? videoId,
      final List<Artist>? artists,
      final List<Thumbnail>? thumbnails,
      final bool? isExplicit,
      final Album? album,
      final String? description,
      final String? playlistId}) = _$ContentImpl;

  factory _Content.fromJson(Map<String, dynamic> json) = _$ContentImpl.fromJson;

  @override
  String? get title;
  @override
  String? get videoId;
  @override
  List<Artist>? get artists;
  @override
  List<Thumbnail>? get thumbnails;
  @override
  bool? get isExplicit;
  @override
  Album? get album;
  @override
  String? get description;
  @override
  String? get playlistId;
  @override
  @JsonKey(ignore: true)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      id: json['id'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      image: json['image'] as String?,
      subtitle: json['subtitle'] as String?,
      subscribers: json['subscribers'] as String?,
      artist: json['artist'] as String?,
      album: json['album'] as String?,
      duration: json['duration'] as String?,
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'images': instance.images,
      'image': instance.image,
      'subtitle': instance.subtitle,
      'subscribers': instance.subscribers,
      'artist': instance.artist,
      'album': instance.album,
      'duration': instance.duration,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drip_search_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DripSearchResultsImpl _$$DripSearchResultsImplFromJson(
        Map<String, dynamic> json) =>
    _$DripSearchResultsImpl(
      title: json['title'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DripSearchResultsImplToJson(
        _$DripSearchResultsImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'items': instance.items,
    };

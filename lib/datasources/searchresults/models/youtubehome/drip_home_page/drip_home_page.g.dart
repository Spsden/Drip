// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drip_home_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DripHomePageImpl _$$DripHomePageImplFromJson(Map<String, dynamic> json) =>
    _$DripHomePageImpl(
      output: (json['output'] as List<dynamic>?)
          ?.map((e) => Output.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DripHomePageImplToJson(_$DripHomePageImpl instance) =>
    <String, dynamic>{
      'output': instance.output,
    };

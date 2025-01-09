// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherType _$WeatherTypeFromJson(Map<String, dynamic> json) => WeatherType(
      id: (json['id'] as num).toInt(),
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherTypeToJson(WeatherType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

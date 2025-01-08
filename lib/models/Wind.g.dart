// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Wind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      windSpeed: (json['speed'] as num).toDouble(),
      windGust: (json['gust'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.windSpeed,
      'gust': instance.windGust,
    };

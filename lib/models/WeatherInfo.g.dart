// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherInfo _$WeatherInfoFromJson(Map<String, dynamic> json) => WeatherInfo(
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherType.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainInfo: WeatherMain.fromJson(json['main'] as Map<String, dynamic>),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      rain: json['rain'] == null
          ? null
          : Rain.fromJson(json['rain'] as Map<String, dynamic>),
      cloud: Cloud.fromJson(json['clouds'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherInfoToJson(WeatherInfo instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'main': instance.mainInfo,
      'wind': instance.wind,
      'rain': instance.rain,
      'clouds': instance.cloud,
    };

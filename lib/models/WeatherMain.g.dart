// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherMain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherMain _$WeatherMainFromJson(Map<String, dynamic> json) => WeatherMain(
      temp: (json['temp'] as num).toDouble(),
      feelsLikeTemp: (json['feels_like'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherMainToJson(WeatherMain instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLikeTemp,
      'humidity': instance.humidity,
    };

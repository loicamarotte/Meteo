
import 'package:Meteo/models/WeatherType.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Cloud.dart';
import 'Rain.dart';
import 'WeatherMain.dart';
import 'Wind.dart';

part 'WeatherInfo.g.dart';

@JsonSerializable()
class WeatherInfo {
  List<WeatherType> weather ;
  @JsonKey(name: "main")
  WeatherMain mainInfo ;
  Wind wind ;
  Rain? rain ;
  @JsonKey(name: "clouds")
  Cloud cloud ;


  WeatherInfo({
    required this.weather,
    required this.mainInfo,
    required this.wind,
    this.rain,
    required this.cloud
  }) ;

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => _$WeatherInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}


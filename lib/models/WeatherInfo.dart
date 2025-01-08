
import 'package:Meteo/models/WeatherType.dart';
import 'package:json_annotation/json_annotation.dart';

import 'WeatherMain.dart';
import 'Wind.dart';

part 'WeatherInfo.g.dart';

@JsonSerializable()
class WeatherInfo {
  List<WeatherType> weather ;
  @JsonKey(name: "main")
  WeatherMain mainInfo ;
  Wind wind ;


  WeatherInfo({
    required this.weather,
    required this.mainInfo,
    required this.wind,
  }) ;

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => _$WeatherInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}


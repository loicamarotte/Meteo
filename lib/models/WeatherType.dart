
import 'package:Meteo/resources/Constants.dart';
import 'package:json_annotation/json_annotation.dart';
part 'WeatherType.g.dart';

@JsonSerializable()
class WeatherType {
  int id ;
  // type global du temps
  String main ;
  // description du temps
  String description ;
  // nom du fichier de l'icon
  String icon ;

  WeatherType({ required this.id, required this.main, required this.description, required this.icon }) ;

  factory WeatherType.fromJson(Map<String, dynamic> json) => _$WeatherTypeFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherTypeToJson(this);

  String getIconUrl() {
    return "${Constants.WEATHER_ICON_URL}${icon}@2x${Constants.WEATHER_ICON_FORMAT}";
  }
}



import 'package:json_annotation/json_annotation.dart';
part 'WeatherType.g.dart';

@JsonSerializable()
class WeatherType {
  int id ;
  // type global du temps
  String main ;
  // description du temps
  String description ;

  WeatherType({ required this.id, required this.main, required this.description,}) ;

  factory WeatherType.fromJson(Map<String, dynamic> json) => _$WeatherTypeFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherTypeToJson(this);
}



import 'package:json_annotation/json_annotation.dart';
part 'Wind.g.dart';

@JsonSerializable()
class Wind {
  // vitesse du vent
  @JsonKey(name: "speed")
  double windSpeed ;
  // vitesse des rafales de vent
  @JsonKey(name: "gust")
  double? windGust ;

  Wind({ required this.windSpeed, required this.windGust,}) ;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}


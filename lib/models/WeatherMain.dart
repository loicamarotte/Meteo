
import 'package:json_annotation/json_annotation.dart';
part 'WeatherMain.g.dart';

@JsonSerializable()
class WeatherMain {
  // température
  double temp ;
  // température ressentie
  @JsonKey(name: "feels_like")
  double feelsLikeTemp ;
  // taux d'humidité
  double humidity ;

  WeatherMain({ required this.temp, required this.feelsLikeTemp, required this.humidity,}) ;

  factory WeatherMain.fromJson(Map<String, dynamic> json) => _$WeatherMainFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherMainToJson(this);
}



import 'package:json_annotation/json_annotation.dart';
part 'Rain.g.dart';

@JsonSerializable()
class Rain {
  // précipitation en mm/h
  @JsonKey(name: "1h")
  double precipitation ;


  Rain({ required this.precipitation}) ;

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);

  Map<String, dynamic> toJson() => _$RainToJson(this);
}


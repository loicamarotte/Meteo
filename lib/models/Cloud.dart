
import 'package:json_annotation/json_annotation.dart';
part 'Cloud.g.dart';

@JsonSerializable()
class Cloud {
  // % nuages
  @JsonKey(name: "all")
  int cloudiness ;


  Cloud({ required this.cloudiness}) ;

  factory Cloud.fromJson(Map<String, dynamic> json) => _$CloudFromJson(json);

  Map<String, dynamic> toJson() => _$CloudToJson(this);
}


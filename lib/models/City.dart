
import 'package:collection/collection.dart';

class City {
  String name ;
  String? frenchName ;
  double lat ;
  double lon ;
  String country ;
  String? state ;

  City({ required this.name, this.frenchName, required this.lat, required this.lon, required this.country, this.state}) ;

  factory City.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final lat = data['lat'] as double;
    final lon = data['lon'] as double;
    final country = data['country'] as String;
    final state = data['state'] as String? ;

    var allLocales = data['local_names'] as Map<String,dynamic>? ;
    final frenchName = allLocales?.entries.firstWhereOrNull((entry) => entry.key == "fr")?.value  ;

    return City(name: name, frenchName: frenchName, lat: lat, lon: lon, country: country, state: state);
  }
}


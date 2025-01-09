import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';

import '../models/City.dart';

class UserCityManager {
  UserCityManager._internal();

  static final UserCityManager _instance = UserCityManager
      ._internal();

  factory UserCityManager() {
    return _instance;
  }

  ValueNotifier<List<City>> _cities = ValueNotifier([]) ;

  reset() {
    _cities.value.clear();
  }
  
  addCity(City city) {
    _cities.value.add(city);
    _cities.notifyListeners() ;
  }
  
  bool isCityAlreadySaved(City city) {
    var res = _cities.value.firstWhereOrNull((c) => c == city) ;
    return  res != null ;
  }

  ValueNotifier<List<City>> getCities() {
    return _cities ;
  }
}
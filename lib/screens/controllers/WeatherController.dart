
import 'package:Meteo/managers/UserCityManager.dart';
import 'package:Meteo/managers/WebServiceManager.dart';
import 'package:Meteo/models/WeatherInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/City.dart';
import '../views/WeatherView.dart';

class WeatherViewController extends StatefulWidget {
  final City city ;

  const WeatherViewController({required this.city, super.key});

  @override
  WeatherController createState() {
    return WeatherController();
  }
}

class WeatherController extends State<WeatherViewController> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isWeatherLoading = ValueNotifier(false);
  bool displayAddCityButton = true ;

  late String cityName ;
  late String countryAndStateName ;

  WeatherInfo? weatherInfo ;


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return WeatherView(this);
  }

  _loadData() async {
    isLoading.value = true ;
    cityName = widget.city.getDisplayedName() ;
    countryAndStateName = widget.city.getCountryAndState() ;
    displayAddCityButton = !UserCityManager().isCityAlreadySaved(widget.city);
    isLoading.value = false ;

    _getWeatherInfo();
  }

  //region Get Data
  _getWeatherInfo() async {
    isWeatherLoading.value = true ;
    var resp = await WebServiceManager().getMeteoApiData(lon: widget.city.lon, lat: widget.city.lat);

    switch(resp.result) {
      case WSResult.SUCCESS:
        weatherInfo= resp.value as WeatherInfo;
        isWeatherLoading.value = false ;
        break;
      case WSResult.ERROR:
        isWeatherLoading.value = false ;
        // TODO: gérer erreur
        break;
      case WSResult.NO_NETWORK:
        isWeatherLoading.value = false ;
        // TODO: gérer pas internet
        break;
    }
  }
  //endregion

  //region User action
  didTapOnAddButton() {
    UserCityManager().addCity(widget.city);
    Navigator.pop(context);
  }
  //endregion

}
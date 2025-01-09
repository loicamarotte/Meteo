
import 'package:Meteo/managers/WebServiceManager.dart';
import 'package:Meteo/models/WeatherInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/City.dart';
import '../views/WeatherView.dart';
import 'HomeController.dart';

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
    cityName = widget.city.frenchName ?? widget.city.name ;
    countryAndStateName = widget.city.state != null ? "${widget.city.state}, ${widget.city.country}" : widget.city.country ;
    isLoading.value = false ;

    _getWeatherInfo();
  }

  //region Get Data
  _getWeatherInfo() async {
    isWeatherLoading.value = true ;
    var resp = await WebServiceManager().getMeteoApiData(lon: widget.city.lon, lat: widget.city.lat);
    print("resp : $resp");
    print(resp.result);

    switch(resp.result) {
      case WSResult.SUCCESS:
        print("success");
        print(resp.value) ;
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

}
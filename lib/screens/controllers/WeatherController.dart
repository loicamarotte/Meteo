
import 'package:Meteo/managers/WebServiceManager.dart';
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

  late String cityName ;
  late String countryAndStateName ;


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

    cityName = widget.city.frenchName ?? widget.city.name ;
    countryAndStateName = widget.city.state != null ? "${widget.city.state}, ${widget.city.country}" : widget.city.country ;

    await WebServiceManager().getMeteoApiData();

  }

}
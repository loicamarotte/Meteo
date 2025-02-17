import 'dart:convert';

import 'package:Meteo/models/WSResponse.dart';
import 'package:Meteo/models/WeatherInfo.dart';
import 'package:http/http.dart';

import 'package:Meteo/utils/ConnectivityUtils.dart';

import '../env/env.dart';
import '../models/City.dart';
import '../resources/Constants.dart';

enum WSResult{
  SUCCESS, ERROR, NO_NETWORK,
}

class WebServiceManager {
  WebServiceManager._internal();

  static final WebServiceManager _instance = WebServiceManager._internal();

  factory WebServiceManager() {
    return _instance;
  }

  static const time_out_seconds_duration = 60;


  Future<WSResponse> getGeoCodingApiData({required String searchString}) async {
    // on vérifie qu'on a bien internet
    if (!(await ConnectivityUtils().isNetworkAvailable())) {
      return WSResponse(result: WSResult.NO_NETWORK);
    }

    try {
      // params de la requête
      var params = <String, String>{};
      params.addEntries({
        MapEntry('q', searchString),
        MapEntry('limit', '3'),
        MapEntry('appid', Env.apiKey),
      });
      // url de la requête
      var url =  Uri.https(
        Constants.API_DOMAIN,
        Constants.API_GEOCODING_WS,
        params,
      );
      // envoi de la requête
      final response = await get(url).timeout(const Duration(seconds: time_out_seconds_duration));

      switch (response.statusCode) {
      // succès
        case 200:

          // converti le json en objet
          List<City> cities = (json.decode(response.body) as List).map((item) =>
              City.fromJson(item)).toSet().toList();

          return WSResponse(result: WSResult.SUCCESS, value: cities);

      // réponse erreur standard
        default:
          print("error !");
          print(response.statusCode) ;
          return WSResponse(result: WSResult.ERROR);
      }
    } catch (exception) {
      print("catched excpetion");
      print(exception);
      return WSResponse(result: WSResult.ERROR);
    }
  }


  Future<WSResponse> getMeteoApiData({required double lon, required double lat}) async {
    // on vérifie qu'on a bien internet
    if (!(await ConnectivityUtils().isNetworkAvailable())) {
      return WSResponse(result: WSResult.NO_NETWORK);
    }

    try {
      var params = <String, String>{};
      params.addEntries({
        MapEntry('lat', "$lat"),
        MapEntry('lon', "$lon"),
        MapEntry('units', "metric"),
        MapEntry('lang', "fr"), // TODO: implémenter int si besoin
        MapEntry('appid', Env.apiKey),
      });
      var url =  Uri.https(
        Constants.API_DOMAIN,
        Constants.API_WEATHER_WS,
        params,
      );
      // envoi de la requête
      final response = await post(url).timeout(const Duration(seconds: time_out_seconds_duration));
      print(response.body);

      switch (response.statusCode) {
      // succès
        case 200:
          WeatherInfo weatherInfo = WeatherInfo.fromJson(json.decode(response.body)) ;
          return WSResponse(result: WSResult.SUCCESS, value: weatherInfo);

      // réponse erreur standard
        default:
          return WSResponse(result: WSResult.ERROR);
      }
    } catch (exception) {
      return WSResponse(result: WSResult.ERROR);
    }
  }

}
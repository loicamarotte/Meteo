import 'package:http/http.dart';

import 'package:Meteo/utils/ConnectivityUtils.dart';

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


  Future<WSResult> getGeoCodingApiData({required String searchString}) async {
    // on vérifie qu'on a bien internet
    if (!(await ConnectivityUtils().isNetworkAvailable())) {
      return WSResult.NO_NETWORK;
    }

    try {
      // params de la requête
      var params = <String, String>{};
      params.addEntries({
        MapEntry('q', searchString),
        MapEntry('limit', '5'),
        MapEntry('appid', '1aabeddc4b91103f061c00e6b5ad4ad3'),
      });
      // url de la requête
      var url =  Uri.https(
        Constants.API_DOMAIN,
        Constants.API_GEOCODING_WS,
        params,
      );
      // envoi de la requête
      final response = await get(url).timeout(const Duration(seconds: time_out_seconds_duration));
      print(response.body);

      switch (response.statusCode) {
      // succès
        case 200:
          return WSResult.SUCCESS;

      // réponse erreur standard
        default:
          return WSResult.ERROR;
      }
    } catch (exception) {
      return WSResult.ERROR;
    }
  }


  Future<WSResult> getMeteoApiData() async {
    // on vérifie qu'on a bien internet
    if (!(await ConnectivityUtils().isNetworkAvailable())) {
      return WSResult.NO_NETWORK;
    }

    try {
      var params = <String, String>{};
      params.addEntries({
        MapEntry('lat', '44.34'),
        MapEntry('lon', '10.99'),
        MapEntry('appid', '1aabeddc4b91103f061c00e6b5ad4ad3'),
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
          return WSResult.SUCCESS;

      // réponse erreur standard
        default:
          return WSResult.ERROR;
      }
    } catch (exception) {
      return WSResult.ERROR;
    }
  }

}
import 'package:Meteo/managers/WebServiceManager.dart';

class WSResponse {
  WSResult result ;
  dynamic value ;

  WSResponse({ required this.result, this.value}) ;
}
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {

  Future<bool> isNetworkAvailable() async {
    final List<ConnectivityResult> connectivityResult = await(
        Connectivity().checkConnectivity());
    return !connectivityResult.contains(ConnectivityResult.none) ;
  }

}

import 'package:flutter/cupertino.dart';

import '../views/SplashView.dart';

class SplashViewController extends StatefulWidget {

  const SplashViewController({super.key});

  @override
  SplashController createState() {
    return SplashController();
  }
}

class SplashController extends State<SplashViewController> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);


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
    return SplashView(this);
  }

  _loadData() async {
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/SplashView.dart';
import 'HomeController.dart';

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
    // simule loading
    // TODO: charger les villes une fois persistées dans l'app
    await Future.delayed(Duration(seconds: 1));

    _goToHome();
  }

  _goToHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeViewController()));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/CustomColors.dart';
import '../../utils/WidgetView.dart';
import '../controllers/SplashController.dart';

class SplashView extends WidgetView<SplashViewController, SplashController> {
  const SplashView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
      child: Scaffold(
        backgroundColor: CustomColors.BACKGROUND_COLOR,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Météo")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
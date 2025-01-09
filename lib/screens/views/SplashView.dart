
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../theme/CustomDimens.dart';
import '../../utils/WidgetView.dart';
import '../controllers/SplashController.dart';

class SplashView extends WidgetView<SplashViewController, SplashController> {
  const SplashView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "Météo",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 44,
                        fontWeight: FontWeight.bold
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: CustomDimens.large_spacing),
                  child: LoadingAnimationWidget.twistingDots(
                    leftDotColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    rightDotColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
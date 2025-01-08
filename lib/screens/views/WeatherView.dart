
import 'package:Meteo/theme/CustomDimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/CustomColors.dart';
import '../../utils/WidgetView.dart';
import '../controllers/WeatherController.dart';

class WeatherView extends WidgetView<WeatherViewController, WeatherController> {
  const WeatherView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(CustomDimens.medium_spacing),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cityTitle(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cityTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
           state.cityName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 30
          )
        ),
        Text(
            state.countryAndStateName,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 16
            )
        ),
      ],
    ) ;

  }
}
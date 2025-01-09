
import 'package:Meteo/models/WeatherMain.dart';
import 'package:Meteo/theme/CustomDimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/Cloud.dart';
import '../../models/Rain.dart';
import '../../models/WeatherInfo.dart';
import '../../models/WeatherType.dart';
import '../../models/Wind.dart';
import '../../utils/WidgetView.dart';
import '../controllers/WeatherController.dart';

class WeatherView extends WidgetView<WeatherViewController, WeatherController> {
  const WeatherView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primaryContainer,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(CustomDimens.medium_spacing),
            child: ValueListenableBuilder(
                valueListenable: state.isLoading,
                builder: (context, bool isLoading, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _addButton(context),
                      _cityTitle(context),
                      _weatherInfo(context),
                    ],
                  );
                }
            ),
          ),
        ),
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    if(!state.displayAddCityButton) {
      return Container();
    }
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        borderRadius: BorderRadius.circular(CustomDimens.container_border_radius),
        onTap: state.didTapOnAddButton,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomDimens.small_spacing,
            vertical: CustomDimens.x_small_spacing,
          ),
          child: Text(
              "Ajouter",
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 30
            )
        ),
        Text(
            state.countryAndStateName,
            style: TextStyle(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSurfaceVariant,
                fontSize: 16
            )
        ),
      ],
    );
  }

  Widget _weatherInfo(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: state.isWeatherLoading,
        builder: (context, bool isLoading, child) {

          if(isLoading) {
            _loadingWidget(context);
          }

          if (state.weatherInfo == null) {
            return Container();
          }

          return Padding(
            padding: const EdgeInsets.only(top: CustomDimens.large_spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _mainWeatherInfo(context, weatherInfo: state.weatherInfo!),
                Padding(
                  padding: const EdgeInsets.only(top: CustomDimens.large_spacing),
                  child: _weatherDetails(context, weatherInfo: state.weatherInfo!),
                )
              ],
            ),
          );
        });
  }

  // region Header Weather
  Widget _mainWeatherInfo(BuildContext context, { required WeatherInfo weatherInfo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: CustomDimens.medium_spacing),
      child: Row(
        children: [
          _temperature(context, weatherMain: weatherInfo.mainInfo),
          Flexible(child: _weatherTypes(context, weather: weatherInfo.weather)),
        ],
      ),
    );
  }

  Widget _weatherTypes(BuildContext context, {required List<WeatherType> weather}) {

    // on se permet une colonne et non une liste car le nb de weather ne devrait pas être grand (1 ou 2)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(var weatherType in weather)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(weatherType.getIconUrl(), width: 60, height: 60, color: Colors.white,),
              Flexible(
                child: Text(
                    weatherType.description ,
                  maxLines:2,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _temperature(BuildContext context, { required WeatherMain weatherMain}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CustomDimens.x_large_spacing),
      child: Column(
        children: [
          Text(
              "${weatherMain.temp.toInt().toString()}°",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 90
              ),
          ),
          Text(
            "Ressenti ${weatherMain.feelsLikeTemp.toInt().toString()}°",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 16
            ),
          ),
        ],
      ),
    ) ;
  }

  //endregion

  //region Weather details

  Widget _weatherDetails(BuildContext context, { required WeatherInfo weatherInfo}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(CustomDimens.small_spacing),
        child: Column(
          children: [
            Wrap(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              alignment: WrapAlignment.spaceAround,
              spacing: CustomDimens.medium_spacing,
              runSpacing: CustomDimens.small_spacing,
              children: [
                _wind(context, wind: weatherInfo.wind),
                _humidity(context, humidity: weatherInfo.mainInfo.humidity),
                _cloudiness(context, cloud: weatherInfo.cloud),
                if(weatherInfo.rain != null) _rain(context, rain: weatherInfo.rain!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _wind(BuildContext context, { required Wind wind}) {
    return _smallContainer(context, key: "Vent", value: "${(wind.windSpeed * 3.6).toInt().toString()}", unity: "km/h");
  }

  Widget _humidity(BuildContext context, { required double humidity}) {
    return _smallContainer(context, key: "Humidité", value: "${humidity.toInt()}", unity: "%");
  }

  Widget _cloudiness(BuildContext context, { required Cloud cloud}) {
    return _smallContainer(context, key: "Nuages", value: "${cloud.cloudiness}", unity: "%");
  }

  Widget _rain(BuildContext context, { required Rain rain}) {
    return _smallContainer(context, key: "Précipitations", value: "${rain.precipitation.toInt()}", unity: "mm/H");
  }

  Widget _smallContainer(BuildContext context, { required String key, required String value, required String unity}) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(CustomDimens.container_border_radius)
      ),
      child: Padding(
        padding: const EdgeInsets.all(CustomDimens.small_spacing),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                Text(
                  " $unity",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
            Text(
              key,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //endregion

  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: Theme.of(context).colorScheme.onSurfaceVariant,
        rightDotColor: Theme.of(context).colorScheme.onSurfaceVariant,
        size: 200,
      ),
    ) ;
  }
}
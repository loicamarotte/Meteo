
import 'dart:async';

import 'package:Meteo/screens/controllers/WeatherController.dart';
import 'package:flutter/material.dart';

import '../../managers/WebServiceManager.dart';
import '../../models/City.dart';
import '../views/HomeView.dart';

class HomeViewController extends StatefulWidget {

  const HomeViewController({super.key});

  @override
  HomeController createState() {
    return HomeController();
  }
}

class HomeController extends State<HomeViewController> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> displaySearchResults = ValueNotifier(false);

  ValueNotifier<List<City>> searchResults = ValueNotifier([]);

  TextEditingController searchBarController = TextEditingController();
  FocusNode searchBarFocusNode = FocusNode() ;

  Timer? _timerSearch;

  @override
  void dispose() {
    super.dispose();
    searchBarFocusNode.removeListener(_focusNodeListener);

  }

  @override
  void initState() {
    super.initState();
    searchBarFocusNode.addListener(_focusNodeListener);
  }

  _focusNodeListener() {
    if(searchBarFocusNode.hasFocus && searchBarController.text.isNotEmpty) {
      displaySearchResults.value = true ;
    }
    else {
      displaySearchResults.value = false ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(this);
  }

  _clearSearch() {
    searchBarController.clear();
    searchBarFocusNode.unfocus();
    searchResults.value.clear();
  }

  //region User action
  didSearchText(String searchText) {

    // si moins de 3 char, on cherche pas
    if(searchText.length < 3) {
      isLoading.value = true ;
      searchResults.value = [] ;
      isLoading.value = false ;
      displaySearchResults.value = false ;
      return ;
    }

    // met à jour l'affichage de l'écran entre resultat de recherche et liste des villes
    displaySearchResults.value = searchText.isNotEmpty ;

    // on attends 300ms que l'utilisateur ait fini de taper
    if(_timerSearch?.isActive ?? false) _timerSearch?.cancel();
    _timerSearch = Timer(const Duration(milliseconds: 300), () async {
      isLoading.value = true ;
      await _getSearchResults() ;
      isLoading.value = false ;
    });
  }

  didTapOnClearSearchBar() {
    _clearSearch();
  }

  didTapOnSearchedCity(City city) {
    _clearSearch();
    _goToWeather(city: city) ;
  }

  didTapOnCity(City city) {
    _goToWeather(city: city) ;
  }
  //endregion

  //region Get Data
  _getSearchResults() async {
    var searchString = searchBarController.text ;
    var resp = await WebServiceManager().getGeoCodingApiData(searchString: searchString) ;

    switch(resp.result) {
      case WSResult.SUCCESS:
        searchResults.value = resp.value as List<City>;
        break;
      case WSResult.ERROR:
        // TODO: gérer erreur
        break;
      case WSResult.NO_NETWORK:
        // TODO: gérer pas internet
        break;
    }
  }
  //endregion

  //region Navigation
  _goToWeather({required City city}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherViewController(city: city)));
  }
  //endregion
}
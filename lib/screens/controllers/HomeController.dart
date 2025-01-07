
import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../managers/WebServiceManager.dart';
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

  TextEditingController searchBarController = TextEditingController();

  Timer? _timerSearch;

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
    return HomeView(this);
  }

  _loadData() async {
  }

  didSearchText(String searchText) {

    // si moins de 3 char, on cherche pas
    if(searchText.length < 3) {
      isLoading.value = true ;
      //resultTitles.value = [] ;
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

  _getSearchResults() async {
    var searchString = searchBarController.text ;
    var resp = await WebServiceManager().getGeoCodingApiData(searchString: searchString) ;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/City.dart';
import '../../theme/CustomDimens.dart';
import '../../utils/WidgetView.dart';
import '../controllers/HomeController.dart';

class HomeView extends WidgetView<HomeViewController, HomeController> {
  const HomeView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(CustomDimens.medium_spacing),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(context),
                  _searchBar(context),
                  _mainContent(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: CustomDimens.medium_spacing),
      child: Text(
          "Météo",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 28,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return SearchBar(
      controller: state.searchBarController,
      hintText: "Rechercher un ville",
      leading: Icon(Icons.search),
      onChanged: (searchText) {
        state.didSearchText(searchText);
      }
    );
  }

  Widget _mainContent(BuildContext) {
    return ValueListenableBuilder(
        valueListenable: state.isLoading,
        builder: (context, bool isLoading, child) {

        return _searchCityList();
      }
    );
  }

  ValueListenableBuilder<List<City>> _searchCityList() {
    return ValueListenableBuilder(
          valueListenable: state.searchResults,
          builder: (context, List<City> searchResults, child) {
            print("searchresults : ${searchResults.length}");

            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, int index) {
                  var item = searchResults[index] ;
                  var text = "${item.frenchName ?? item.name}, ${item.country}" ;
                  if(item.state != null) {
                    text += ", ${item.state}";
                  }
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left:CustomDimens.medium_spacing, top: CustomDimens.small_spacing, right: CustomDimens.medium_spacing),
                      child: Text(text),
                    ),
                    onTap: () { state.didTapOnSearchedCity(item) ;},
                  );
                },
                  itemCount: searchResults.length
                ),
            );
          });
  }
}
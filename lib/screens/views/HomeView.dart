
import 'package:Meteo/managers/UserCityManager.dart';
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
      trailing: [_clearButton()],
      onChanged: (searchText) {
        state.didSearchText(searchText);
      },
      focusNode: state.searchBarFocusNode,
    );
  }

  Widget _clearButton() {
    return InkWell(
      onTap: state.didTapOnClearSearchBar,
      child: Icon(Icons.clear)
    ) ;
  }

  Widget _mainContent() {
    return ValueListenableBuilder(
        valueListenable: state.isLoading,
        builder: (context, bool isLoading, child) {

          return ValueListenableBuilder(
              valueListenable: state.displaySearchResults,
              builder: (context, bool displaySearchResults, child) {
                if(displaySearchResults) {
                  return _searchCityList();
                }
                return _userCityList();
              });
      }
    );
  }

  Widget _searchCityList() {
    return ValueListenableBuilder(
          valueListenable: state.searchResults,
          builder: (context, List<City> searchResults, child) {

            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: CustomDimens.medium_spacing),
                itemBuilder: (context, int index) {
                  var item = searchResults[index] ;
                  var text = "${item.frenchName ?? item.name}, ${item.country}" ;
                  if(item.state != null) {
                    text += ", ${item.state}";
                  }
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left:CustomDimens.medium_spacing, top: CustomDimens.small_spacing, right: CustomDimens.medium_spacing),
                      child: Text(
                          text,
                          style: TextStyle(
                              fontSize: 16
                          )
                      ),
                    ),
                    onTap: () { state.didTapOnSearchedCity(item) ;},
                  );
                },
                  itemCount: searchResults.length
                ),
            );
          });
  }

  Widget _userCityList() {
    return ValueListenableBuilder(
      valueListenable: UserCityManager().getCities(),
      builder: (context, List<City> cities, child) {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: CustomDimens.large_spacing),
            itemCount: cities.length,
            itemBuilder: (context, int index) {
            var city = cities[index];
            print(city);
            return Padding(
              padding: const EdgeInsets.only(bottom: CustomDimens.small_spacing),
              child: InkWell(
                onTap: () { state.didTapOnCity(city); },
                  child: _cityCard(context, city)
              ),
            );
          }),
        );
      },
    );
  }

  Container _cityCard(BuildContext context, City city) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(CustomDimens.container_border_radius)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CustomDimens.small_spacing,
          horizontal: CustomDimens.medium_spacing
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                city.getDisplayedName(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            Text(
                city.getCountryAndState(),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 16
                )
            )
          ],
        ),
      ),
    );
  }
}
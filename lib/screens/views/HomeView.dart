
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/CustomColors.dart';
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
       // backgroundColor: CustomColors.BACKGROUND_COLOR,
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
}
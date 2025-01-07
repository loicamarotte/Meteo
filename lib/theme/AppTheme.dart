import 'package:flutter/material.dart';

import 'CustomColors.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    colorScheme: const ColorScheme.light(
      primary: CustomColors.DARK_BLUE,
      secondary: CustomColors.PINK,
      onPrimary: CustomColors.BLACK,
      primaryContainer: CustomColors.LIGHT_BLUE,
      onPrimaryContainer: CustomColors.BLACK,
      onSecondary: CustomColors.BLACK,
      surface: CustomColors.BEIGE,
      onSurface: CustomColors.BLACK,
      onSurfaceVariant: CustomColors.NAVY_BLUE,
    ),
  );

  static const cardBorderRadius = BorderRadius.all(Radius.circular(5)) ;

}
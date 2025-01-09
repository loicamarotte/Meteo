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
      onSecondary: CustomColors.BLACK,
      primaryContainer: CustomColors.MEDIUM_BLUE,
      secondaryContainer: CustomColors.DARK_BLUE,
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      surface: CustomColors.BEIGE,
      onSurface: CustomColors.BLACK,
      onSurfaceVariant: CustomColors.NAVY_BLUE,
      surfaceBright: CustomColors.DARK_BLUE
    ),
  );

  static const cardBorderRadius = BorderRadius.all(Radius.circular(5)) ;

}
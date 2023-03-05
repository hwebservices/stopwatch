import 'package:flutter/material.dart';

const fontFamily = 'Poppins';

final themeLight = ThemeData(
  primaryColorLight: const Color.fromARGB(255, 247, 248, 249),
  brightness: Brightness.light,
  primaryColor: const Color.fromARGB(255, 132, 190, 241),
  highlightColor: Colors.amber,
  canvasColor: Colors.white,
  fontFamily: fontFamily,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan)
      .copyWith(
        secondary: Colors.blueAccent,
        brightness: Brightness.light,
      )
      .copyWith(background: Colors.white),
);

final themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColorDark: const Color.fromARGB(255, 250, 251, 252),
  primaryColor: const Color.fromARGB(255, 16, 29, 138),
  highlightColor: const Color.fromARGB(255, 2, 6, 80),
  canvasColor: Colors.white,
  fontFamily: fontFamily,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
      .copyWith(
          secondary: const Color.fromARGB(255, 9, 13, 94),
          brightness: Brightness.dark)
      .copyWith(background: const Color.fromARGB(255, 9, 13, 94)),
);

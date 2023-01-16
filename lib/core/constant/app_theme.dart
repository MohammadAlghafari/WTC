import 'package:flutter/material.dart';
import 'package:wtc/core/constant/app_color.dart';

import 'app_settings.dart';

class AppTheme {
  static final ThemeData defTheme = ThemeData(
    scaffoldBackgroundColor: kScaffoldColor,
    primaryIconTheme: const IconThemeData(color: Colors.white),
    fontFamily: kAppFont,
    // splashColor: Colors.transparent,
    // highlightColor: Colors.transparent,
    // appBarTheme: const AppBarTheme(
    //   elevation: 0,
    //   color: Colors.transparent,
    //   centerTitle: true,
    //   actionsIconTheme: IconThemeData(size: 16, color: Colors.black),
    // ),

    iconTheme: const IconThemeData(color: Colors.white),
    textTheme:
        TextTheme(bodyText2: TextStyle(color: AppColor.kDefaultFontColor)),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coinrich/core/constant/colors.dart';

final _lightThemeData = ThemeData(
    fontFamily: "sinkinsans",
    primaryColor: AppColors.black,
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.white
);
final _darkThemeData = ThemeData.dark();

final primaryMaterialTheme = _lightThemeData.copyWith(
  textTheme: _lightThemeData.textTheme.apply(
    fontFamily: 'Arial',
  ),
);
final darkMaterialTheme = _darkThemeData.copyWith(
  textTheme: _darkThemeData.textTheme.apply(
    fontFamily: 'Arial',
  ),
);

const primaryCupertinoTheme = CupertinoThemeData(
  primaryColor: CupertinoDynamicColor.withBrightness(
    color: Colors.grey,
    darkColor: Colors.black45,
  ),
);

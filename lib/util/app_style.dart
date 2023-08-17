import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'res_dimens.dart';

abstract class AppStyles {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppConstants.appFontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppConstants.appFontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static double? getTextSize(key) {
    final textSize = {
      "XS": 12.0,
      "S": 14.0,
      "M": 16.0,
      "L": 18.0,
      "XL": 22.0,
      "XXL": 26.0,
      "XXXL": 30.0
    };
    return textSize[key];
  }

  static textStyle(
      {fontSize, color, decoration, height, weight, decorationColor,fontStyle}) {
    return TextStyle(
        fontWeight: weight ?? FontWeight.w400,
        // overflow: TextOverflow.ellipsis,
        fontSize: fontSize ?? dimen12,
        fontStyle:fontStyle?? FontStyle.normal,
        fontFamily: AppConstants.appFontFamily,
        color: color ?? AppColors.headingFontColor,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: decorationColor ?? color ?? AppColors.headingFontColor,
        height: height ?? 1.4);
  }
}

import 'package:flutter/material.dart';

import 'app_style.dart';

class TextStyles {

  static TextStyle get main => TextStyle(
     color: AppStyle.accentColor,
     fontSize: 13,
     fontWeight: FontWeight.w300
  );

  static TextStyle get whiteBoldText => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: AppStyle.textColor
  );

  static TextStyle get mainWhite => TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: AppStyle.textColor
  );

  static TextStyle get appBarStyle => TextStyle(
    color: AppStyle.accentColor,
    fontWeight: FontWeight.w400,
    fontSize: 20
  );

  static TextStyle get buttonTextStyle => TextStyle(
    color: AppStyle.accentColor,
    fontWeight: FontWeight.w400,
    fontSize: 17
  );

  static TextStyle get formLabelStyle => TextStyle(
    color: AppStyle.accentColor,
    fontWeight: FontWeight.w500
  );

  static TextStyle get formTextStyle => TextStyle(
    color: AppStyle.accentColor,
    fontWeight: FontWeight.w300
  );

  static TextStyle get deleteButtonTextStyle => TextStyle(
    color: AppStyle.errorColor,
    fontWeight: FontWeight.w400
  );

  static TextStyle get cancelButtonTextStyle => TextStyle(
    color: AppStyle.unselectedColor,
    fontWeight: FontWeight.w300
  );
}
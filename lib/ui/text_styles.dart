import 'package:flutter/material.dart';

import 'app_style.dart';

class TextStyles {

  static TextStyle get main => TextStyle(
     color: AppStyle.accentColor,
     fontSize: 13,
     fontWeight: FontWeight.w300
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
}
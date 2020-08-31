import 'package:babymoon/ui/text_styles.dart';
import 'package:flutter/material.dart';

class AppStyle {

  static AppBar appBar(String title) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title, style: TextStyles.appBarStyle),
      centerTitle: true,
    );
  }

  static Color get backgroundColor => Colors.grey[900];

  static Color get textColor => Colors.white;

  static Color get accentColor => Color(0xFFFEFCD7);

  static Color get blueyColor => Colors.indigo[400];

  static Color get unselectedColor => Colors.grey;

  static Color get errorColor => Colors.red;
}
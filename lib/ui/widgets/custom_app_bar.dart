import 'package:flutter/material.dart';

class CustomAppBar {

  static getAppBar(String title, bool leadingIcon) {
    return AppBar(
      title: Container(
        padding: EdgeInsets.only(left: leadingIcon ? 0 : 50),
        child: Text('Sleep Tracker'),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber[200],
              Colors.yellow[700],
              Colors.amber[200],
            ]
          )
        )
      ),
    );
  }
}
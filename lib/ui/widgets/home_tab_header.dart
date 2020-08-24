import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';

class HomeTabHeader extends StatelessWidget {

  final String _headerText = "Get to know your baby's sleep patterns and keep\n"
              "track of how much sleep they are getting here"; 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Space(20),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.brightness_2, color: Colors.white),
          ),
          Space(20),
          Text(
            _headerText,
            style: TextStyle(
              color: AppStyle.textColor,
              fontWeight: FontWeight.normal
            ),
          )
        ],
      ),
    );
  }
}
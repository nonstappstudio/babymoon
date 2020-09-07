import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';

class HomeTabHeader extends StatelessWidget {

  final bool doShowTitle;

  HomeTabHeader([this.doShowTitle]);

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
          RotatedBox(
            quarterTurns: 90,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.yellow[600],
              child: Icon(Icons.brightness_2, color: Colors.white, size: 35),
            ),
          ),
          Space(20),
          if (doShowTitle) Text(
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
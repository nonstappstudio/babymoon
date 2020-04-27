import 'package:flutter/material.dart';

class Space extends StatelessWidget {

  final double space;

  Space(this.space);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: space, top: space));
  }
  
}
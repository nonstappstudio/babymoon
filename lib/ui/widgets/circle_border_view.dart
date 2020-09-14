import 'package:flutter/material.dart';
import '../app_style.dart';

class CircleBorderView extends StatelessWidget {

  final Widget child;
  final Color color;

  CircleBorderView({@required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 3,
          color: color != null ? color : AppStyle.blueyColor,
          style: BorderStyle.solid
        )
      ),
      child: Center(
        child: child
      ),
    );
  }
}
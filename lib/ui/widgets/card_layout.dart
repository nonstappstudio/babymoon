import 'package:flutter/material.dart';

class CardLayout extends StatelessWidget {

  final Widget child;
  final Color color;
  final double insidePadding;

  CardLayout({
    this.child,
    this.color,
    this.insidePadding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color
      ),
      child: Padding(
        padding: EdgeInsets.all(insidePadding),
        child: child,
      )
    );
  }
}
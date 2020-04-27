import 'package:flutter/material.dart';

class TappableCustomField extends StatelessWidget {
  final Widget child;
  final Function onTap;

  TappableCustomField({
    Key key,
    @required this.child,
    @required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: AbsorbPointer(
        child: child,
      ),
    );
  }
}
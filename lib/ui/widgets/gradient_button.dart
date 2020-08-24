import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {

  final String text;
  final dynamic function;

  GradientButton({
    this.text,
    this.function
  }): assert (function != null, text != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width - 80,
      child: RaisedButton(
        onPressed: () => function(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0)
        ),
        padding: EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: AppStyle.backgroundColor
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyles.buttonTextStyle
          ),
        ),
      ),
    );
  }
}
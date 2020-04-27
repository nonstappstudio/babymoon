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
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: () => function(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0)
        ),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[700], 
                  Color(0xff64B6FF)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30.0)
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerWrapper extends StatefulWidget {

  final int initialValue;
  final Function updateParent;
  final bool isHours;

  NumberPickerWrapper({
    @required this.initialValue,
    @required this.isHours,
    @required this.updateParent,
  });

  @override
  _NumberPickerWrapperState createState() => _NumberPickerWrapperState();
}

class _NumberPickerWrapperState extends State<NumberPickerWrapper> {

  int currentValue;

  @override
  void initState() {
    currentValue = widget.initialValue ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return NumberPicker.integer(
      initialValue: currentValue,
      minValue: 0,
      maxValue: 59,
      infiniteLoop: true,
      onChanged: (num) {
        setState(() {
          currentValue = num;
        });
        widget.updateParent(num, widget.isHours);
      },
    );

  }
}
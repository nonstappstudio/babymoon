import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class DateForm extends StatefulWidget {

  static final GlobalKey<_DateFormState> fKey =
    GlobalKey<_DateFormState>();

  DateForm({
    Key key
  }): super (key: key);

  @override
  _DateFormState createState() => _DateFormState();
}

class _DateFormState extends State<DateForm> {

  DateFormat dateFormat = DateFormat("yyyy MMMM dd, HH:mm");
  DateTime currentValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      onChanged: (date) => currentValue = date,
      initialValue: DateTime.now(),
      attribute: 'date',
        style: TextStyle(
          color: Colors.grey
        ),
        format: dateFormat,
        decoration: InputDecoration(
        labelText: 'Date and time',
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500
        ),
        prefixIcon: Icon(Icons.event, color: Theme.of(context).primaryColor),
        suffixIcon: Icon(
          Icons.edit, 
          size: 15,
          color: Theme.of(context).primaryColor,
        )
      ),
    );
  }
}
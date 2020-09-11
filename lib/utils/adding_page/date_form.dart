import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/text_styles.dart';
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

  DateTime get lastWeek => DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day - 7
  );

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      onChanged: (date) => currentValue = date,
      initialValue: DateTime.now(),
      firstDate: lastWeek,
      lastDate: DateTime.now(),
      attribute: 'date',
        style: TextStyles.formTextStyle,
        format: dateFormat,
        decoration: InputDecoration(
        labelText: 'Date and time',
        labelStyle: TextStyles.formLabelStyle,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppStyle.accentColor)
        ),
        prefixIcon: Icon(Icons.event, color: AppStyle.accentColor),
        suffixIcon: Icon(
          Icons.edit, 
          size: 15,
          color: AppStyle.accentColor,
        )
      ),
    );
  }
}
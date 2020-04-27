import 'package:babymoon/ui/models/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:babymoon/utils/extensions/type_extension.dart';

class TypeForm extends StatefulWidget {

  static final GlobalKey<_TypeFormState> fKey =
    GlobalKey<_TypeFormState>();

  TypeForm({
    Key key
  }): super (key: key);

  @override
  _TypeFormState createState() => _TypeFormState();
}

class _TypeFormState extends State<TypeForm> {

  SleepType currentValue;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      onChanged: (type) => currentValue = type,
      attribute: 'type',
        style: TextStyle(
          color: Colors.grey
        ),
        icon: Padding(
          padding: const EdgeInsets.only(right: 11.0),
          child: Icon(
            Icons.arrow_drop_down, 
            color: Theme.of(context).primaryColor
          ),
        ),
        decoration: InputDecoration(
        labelText: 'Sleep type',
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.brightness_2, 
          color: Theme.of(context).primaryColor
        ),
      ),
      items: SleepType.values.map((t) {
        return DropdownMenuItem(
          child: Text(
            t.stringValue,
          ),
          value: t,
        );
      }).toList()
    );
  }
}
import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/models/record.dart';
import 'package:babymoon/ui/text_styles.dart';
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
      dropdownColor: AppStyle.backgroundColor,
      onChanged: (type) => currentValue = type,
      attribute: 'type',
        style: TextStyles.formTextStyle,
        icon: Padding(
          padding: const EdgeInsets.only(right: 11.0),
          child: Icon(
            Icons.arrow_drop_down, 
            color: Theme.of(context).primaryColor
          ),
        ),
        decoration: InputDecoration(
        labelText: 'Sleep type',
        labelStyle: TextStyles.formLabelStyle,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyle.accentColor)
          ),
        prefixIcon: Icon(
          Icons.brightness_2, 
          color: AppStyle.accentColor
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
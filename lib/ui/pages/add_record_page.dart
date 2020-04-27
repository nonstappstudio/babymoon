import 'package:babymoon/ui/models/record.dart';
import 'package:babymoon/utils/adding_page/all_forms.dart';
import 'package:babymoon/utils/space.dart';
import 'package:babymoon/ui/widgets/custom_app_bar.dart';
import 'package:babymoon/ui/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddRecordPage extends StatefulWidget {

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar('Sleeping tracker', true),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/sleeping.jpg'
                    )
                  ),
                ),
                Space(25),
                FormBuilder(
                  child: Column(
                    children: <Widget>[
                      DateForm(key: DateForm.fKey),
                      TypeForm(key: TypeForm.fKey),
                      DurationForm(key: DurationForm.fKey)
                    ],
                  )
                ),
                Space(70),
                GradientButton(
                  text: 'Save',
                  function: () {
                    final _date = DateForm.fKey.currentState.currentValue;
                    final _type = TypeForm.fKey.currentState.currentValue;
                    final _duration = DurationForm.fKey.currentState.currentValue;

                    if (_date != null && _type != null && _duration != null) {
                      Navigator.of(context).pop(
                        Record(
                          dateTime: _date,
                          type: _type,
                          duration: _duration
                        )
                      );
                    } else {
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[400],
                          content: Text(
                            'Please fill out all of the fields',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          duration: Duration(seconds: 2),
                        )
                      );
                    }
                  },
                )
              ],
            ),
          ),
        )
      ),
    ); 
  }
}
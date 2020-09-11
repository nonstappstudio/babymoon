import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/models/record.dart';
import 'package:babymoon/utils/adding_page/all_forms.dart';
import 'package:babymoon/utils/space.dart';
import 'package:babymoon/ui/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddRecordPage extends StatefulWidget {

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {


  void _displayError(BuildContext context, String text) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[400],
        content: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        duration: Duration(seconds: 2),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppStyle.appBar('Add record'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/night.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Builder(
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Space(32),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/images/sleeping.jpg'
                        )
                      ),
                    ),
                  ),
                  Space(25),
                  FormBuilder(
                    child: Column(
                      children: <Widget>[
                        DateForm(key: DateForm.fKey),
                        Space(16),
                        TypeForm(key: TypeForm.fKey),
                        Space(16),
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
                      final _duration = DurationForm.fKey
                                                    .currentState.currentValue;
                      
                      double durationDouble 
                              = (_duration.hour + _duration.minute)/60.0;

                      if (_date != null && _type != null && _duration != null) {
                        if (durationDouble <= 0) {
                          _displayError(
                            context,
                            'Sleep duration must be bigger than 0 minutes'
                          );
                        } else {
                          Navigator.of(context).pop(
                            Record(
                              id: _date.millisecondsSinceEpoch,
                              dateTime: _date,
                              type: _type,
                              duration: _duration,
                            )
                          );
                        }
                      } else {
                        _displayError(
                          context, 
                          'Please fill out all of the fields'
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ),
      ),
    ); 
  }
}
import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/ui/widgets/tappable_custom_field.dart';
import 'package:babymoon/utils/adding_page/number_picker_wrapper.dart';
import 'package:flutter/material.dart';

import '../space.dart';

class DurationForm extends StatefulWidget {

  static final GlobalKey<_DurationFormState> fKey =
    GlobalKey<_DurationFormState>();

  DurationForm({
    Key key
  }): super (key: key);

  @override
  _DurationFormState createState() => _DurationFormState();
}

class _DurationFormState extends State<DurationForm> {

  TextEditingController _controller = TextEditingController();
  TimeOfDay currentValue;

  int _hours;
  int _minutes;

  String _timeString() {
    return _hours == 1
      ? _minutes == 1
        ? '$_hours hour $_minutes minute'
        : '$_hours hour $_minutes minutes'
      : _minutes == 1
        ? '$_hours hours $_minutes minute'
        : '$_hours hours $_minutes minutes';
  }

  void updateTime(num value, bool isHours) {
    setState(() {
      isHours ? _hours = value : _minutes = value;

      currentValue = TimeOfDay(hour: _hours, minute: _minutes);
        _controller.text = _timeString();
    });

  }

  void _expand() {
    showModalBottomSheet(
      context: context, 
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'hours',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Space(5),
                NumberPickerWrapper(
                  isHours: true,
                  updateParent: updateTime,
                  initialValue: currentValue?.hour ?? 0,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'minutes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Space(5),
                NumberPickerWrapper(
                  isHours: false,
                  updateParent: updateTime,
                  initialValue: currentValue?.minute ?? 0,
                ),
              ],
            ),
          ],
        )
      )
    );
  }

  @override
  void initState() {
    _hours = 0;
    _minutes = 0;
    currentValue = TimeOfDay(hour: _hours, minute: _minutes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TappableCustomField(
      onTap: () => _expand(),
      child: TextFormField(
        style: TextStyles.formTextStyle,
        controller: _controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyle.accentColor)
          ),
          labelText: 'Sleep duration',
          labelStyle: TextStyles.formLabelStyle,
          prefixIcon: Icon(
            Icons.access_time, 
            color: AppStyle.accentColor
          ),
        ),
      )
    );
  }
}
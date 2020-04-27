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
    _controller.text = _timeString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TappableCustomField(
      onTap: () => _expand(),
      child: TextFormField(
        style: TextStyle(
          color: Colors.grey,
        ),
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Sleep duration',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            Icons.access_time, 
            color: Theme.of(context).primaryColor
          ),
        ),
      )
    );
  }
}
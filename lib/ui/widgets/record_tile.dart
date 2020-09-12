import 'package:babymoon/models/record.dart';
import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:babymoon/utils/extensions/type_extension.dart';

class RecordTile extends StatelessWidget {

  final Record record;
  
  RecordTile({@required this.record});

  String get _durationHours => record.duration.hour == 1 
    ? '${record.duration.hour} hour'
    : '${record.duration.hour} hours';

  String get _durationMinutes => record.duration.minute == 1 
    ? '${record.duration.minute} minute'
    : '${record.duration.minute} minutes';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.white,
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: AppStyle.backgroundColor,
              width: 90,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    DateFormat('hh:mm').format(record.dateTime),
                    style: TextStyles.whiteBoldText
                  ),
                  Space(2),
                  Text(
                    DateFormat('a').format(record.dateTime),
                    style: TextStyles.main.copyWith(color: Colors.grey[200])
                  )
                ],
              ),
            ),
            Flexible(
              child: ListTile(
                isThreeLine: true,
                title: Text(
                record.type.stringValue,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text('$_durationHours $_durationMinutes')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
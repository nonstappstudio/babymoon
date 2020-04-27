import 'package:babymoon/ui/models/record.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:babymoon/utils/extensions/type_extension.dart';

class RecordTile extends StatelessWidget {

  final Record record;
  final bool first;
  final bool last;
  
  RecordTile({@required this.record, this.first, this.last});

  //TODO: Do pluralization with locale (intl)
  String get _durationHours => record.duration.hour == 1 
    ? '${record.duration.hour} hour'
    : '${record.duration.hour} hours';

  String get _durationMinutes => record.duration.minute == 1 
    ? '${record.duration.minute} minute'
    : '${record.duration.minute} minutes';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new SizedBox(
        height: 60.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(first ? 10 : 0),
                  bottomLeft: Radius.circular(last ? 10 : 0)
                ),
                color: Colors.grey[200]
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    DateFormat('hh:mm').format(record.dateTime),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    DateFormat('a').format(record.dateTime),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListTile(
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
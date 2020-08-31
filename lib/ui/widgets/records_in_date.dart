import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/models/record.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'record_tile.dart';
import 'package:intl/intl.dart';

class RecordsInDate extends StatelessWidget {

  final DateTime date;
  final List<Record> records;
  final Function onDelete;

  RecordsInDate({
    this.date,
    this.records,
    this.onDelete
  });
  

  Future<bool> _confirmDismiss(BuildContext context, Record record) async {

    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          'Are you sure that you want to delte this record?'
        ),
        actions: [
          FlatButton(
            child: Text(
              'Cancel',
              style: TextStyles.deleteButtonTextStyle,
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FlatButton(
            child: Text(
              'Delete',
              style: TextStyles.deleteButtonTextStyle,
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      )
    );

    return Future.value(result);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '${DateFormat('EEEE, dd MMM yyyy').format(date)}',
                style: TextStyle(
                  fontSize: 18,
                  color: AppStyle.textColor,
                  fontWeight: FontWeight.w300
                ),
              ),
            ],
          ),
          Space(5),
          Container(
            color: Colors.transparent,
            child: ListView.separated(
              separatorBuilder: (_, __) 
                  => Divider(color: Colors.transparent, height: 8),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (context, index) {

                final record = records[index];

                records.sort((a, b) => b.dateTime.compareTo(a.dateTime));

                return Dismissible(
                  confirmDismiss: (_) => _confirmDismiss(context, record),
                  key: Key('${records[index].id}'),
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Icon(Icons.delete_sweep, color: Colors.white),
                      ),
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  dragStartBehavior: DragStartBehavior.start,
                  onDismissed: (_) => onDelete(record),
                  child: RecordTile(record: record)
                );
              }
            ),
          ),
          Space(15)
        ]
      ),
    );
  }
}
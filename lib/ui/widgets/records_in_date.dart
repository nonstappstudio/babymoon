import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/models/record.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';
import 'record_tile.dart';
import 'package:intl/intl.dart';

class RecordsInDate extends StatelessWidget {

  final DateTime date;
  final List<Record> records;

  RecordsInDate({
    this.date,
    this.records
  });

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

                records.sort((a, b) => b.dateTime.compareTo(a.dateTime));

                return RecordTile(record: records[index]);
              }
            ),
          ),
          Space(15)
        ]
      ),
    );
  }
}
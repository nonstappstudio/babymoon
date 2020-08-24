import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/models/record.dart';
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            elevation: 2,
            child: ListView.separated(
              separatorBuilder: (context, index) 
                  => Divider(color: Colors.grey[400], height: 0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (context, index) {

                records.sort((a, b) => b.dateTime.compareTo(a.dateTime));
                
                if (records[index] == records.first) {
                  return RecordTile(
                    record: records[index], 
                    first: true, 
                    last: false
                  );
                } else if (records[index] == records.last) {
                  return RecordTile(
                    record: records[index], 
                    first: false, 
                    last: true
                  );
                }
                return RecordTile(
                  record: records[index], 
                  first: false, 
                  last: false
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
import 'package:flutter/material.dart';

class Record {

  final DateTime dateTime;
  final SleepType type;
  final TimeOfDay duration;

  Record({
    this.dateTime,
    this.type,
    this.duration
  });

  DateTime get comparableDate => DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day
  );

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      dateTime: json['dateTime'],
      type: json['type'],
      duration: json['duration']
    );
  }

  Map<String, dynamic> toJson() => {
    'dateTime': dateTime,
    'type': type,
    'duration': duration,
  };

  Map<String, dynamic> listToJson(List<Record> records) => {
    'allRecords': records.map((r) {
      r.toJson();
    }).toList()
  };
}


enum SleepType {
  NIGHTS_SLEEP,
  NAP
}
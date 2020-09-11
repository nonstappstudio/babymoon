import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:babymoon/utils/extensions/all_extensions.dart';

class Record {

  final int id;
  final DateTime dateTime;
  final SleepType type;
  final TimeOfDay duration;
  final int sortableDate;

  Record({
    this.id,
    this.dateTime,
    this.type,
    this.duration,
    this.sortableDate
  });

  DateTime get comparableDate => DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day
  );

  int get durationInMinutes => (duration.hour * 60) + duration.minute;

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
      type: SleepType.values
            .firstWhere((t) => describeEnum(t).toLowerCase() == json['type']),
      duration: (json['duration'] as String).timeOfDay,
      sortableDate: json['sortableDate']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': dateTime.millisecondsSinceEpoch,
    'dateTime': dateTime.millisecondsSinceEpoch,
    'type': type.dbSafeString,
    'duration': duration.toJson,
    'sortableDate': sortableDate
  };
}


enum SleepType {
  NIGHTS_SLEEP,
  NAP
}
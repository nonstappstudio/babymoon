import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:babymoon/utils/extensions/all_extensions.dart';

class Record {

  final int id;
  final DateTime dateTime;
  final SleepType type;
  final TimeOfDay duration;

  Record({
    this.id,
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
      id: json['id'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
      type: SleepType.values
            .firstWhere((t) => describeEnum(t).toLowerCase() == json['type']),
      duration: (json['duration'] as String).timeOfDay
    );
  }

  Map<String, dynamic> toJson() => {
    'id': dateTime.millisecondsSinceEpoch,
    'dateTime': dateTime.millisecondsSinceEpoch,
    'type': type.dbSafeString,
    'duration': duration.toJson,
  };
}


enum SleepType {
  NIGHTS_SLEEP,
  NAP
}
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
}


enum SleepType {
  NIGHTS_SLEEP,
  NAP
}
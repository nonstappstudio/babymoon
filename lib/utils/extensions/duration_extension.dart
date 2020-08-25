import 'package:flutter/material.dart';

extension DurationExtension on TimeOfDay {

  String get toJson => '${this.hour}:${this.minute}';
}
import 'package:flutter/material.dart';

extension StringExtension on String {

  TimeOfDay get timeOfDay => TimeOfDay(
     hour: int.tryParse(this.split(':')[0] ?? '0'),
     minute: int.tryParse(this.split(':')[1] ?? '0'),
  );
}
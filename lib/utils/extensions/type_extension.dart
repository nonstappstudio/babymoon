import 'package:babymoon/models/record.dart';
import 'package:babymoon/ui/app_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension TypeString on SleepType {
  String get stringValue =>
      describeEnum(this)[0]
        .toUpperCase() + 
      describeEnum(this).substring(1).toLowerCase()
        .replaceAll('ights', "ight's").replaceAll('_', ' ');

  String get dbSafeString => describeEnum(this).toLowerCase();

  Color get color => this == SleepType.NAP ? AppStyle.accentColor : Colors.blue;
} 
import 'package:babymoon/models/record.dart';
import 'package:flutter/foundation.dart';

extension TypeString on SleepType {
  String get stringValue =>
      describeEnum(this)[0]
        .toUpperCase() + 
      describeEnum(this).substring(1).toLowerCase()
        .replaceAll('ights', "ight's").replaceAll('_', ' ');

  String get dbSafeString => describeEnum(this).toLowerCase();
} 
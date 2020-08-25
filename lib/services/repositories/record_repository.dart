import 'dart:convert';

import 'package:babymoon/models/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordRepository {

  static Future<bool> saveRecord([List<Record> allRecords]) async {

    final prefs = await SharedPreferences.getInstance();

    return await prefs.setString('records', json.encode(allRecords));
  }

  static List<dynamic> getAllRecords(SharedPreferences prefs) {

    return !prefs.containsKey('records')
      ? []
      : json.decode(prefs.get('records'));
  }
}
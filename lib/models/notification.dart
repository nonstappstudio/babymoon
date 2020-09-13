import 'package:flutter/material.dart';

class NotificationObj {
  final int id;
  final String title;
  final String body;
  final String payload;

  NotificationObj({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
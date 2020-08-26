import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'ui/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.yellow[600],
        primaryColor: Colors.blue[800],
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen()
    );
  }
}



class MainScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      body: HomePage()
    );
  }
}


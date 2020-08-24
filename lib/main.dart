import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/pages/home_page.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return HomePage();

          } else if (snapshot.hasError) {

            return Center(  
              child: Text(
                'Error while loading data: ${snapshot.error.toString()}',
                style: TextStyles.main.copyWith(color: Colors.red),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}


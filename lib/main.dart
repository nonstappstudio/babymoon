import 'package:babymoon/models/user.dart';
import 'package:babymoon/services/repositories/user_repository.dart';
import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/pages/first_launch_page.dart';
import 'package:babymoon/ui/pages/home_page.dart';
import 'package:babymoon/ui/widgets/error_body.dart';
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
        accentColor: AppStyle.accentColor,
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/night.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: FutureBuilder<User>(
        future: UserRepository.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            final user = snapshot.data;

            if (user != null) {
              return HomePage();
            }

            return FirstLaunchPage();

          } else if (snapshot.hasError) {

            return ErrorBody(
              errorText: 'Could not get user data',
              onRefresh: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (c) => MainScreen() 
                )
              ),
            );

          } else if (snapshot.data == null) {

            return FirstLaunchPage();

          }

          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}


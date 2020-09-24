import 'package:babymoon/models/user.dart';
import 'package:babymoon/services/repositories/user_repository.dart';
import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/pages/first_launch_page.dart';
import 'package:babymoon/ui/widgets/error_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'ui/pages/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
        (int id, String title, String body, String payload) async {

        print('notification');

      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Babymoon',
      theme: ThemeData(
        accentColor: AppStyle.accentColor,
        primaryColor: Colors.blue[800],
        primarySwatch: Colors.indigo,
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

          } else if (snapshot.connectionState == ConnectionState.waiting) {

            return Center(child: CircularProgressIndicator());

          } else if (snapshot.data == null) {

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
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}


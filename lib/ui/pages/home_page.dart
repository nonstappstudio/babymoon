import 'dart:io';

import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/pages/home/home_tab.dart';
import 'package:babymoon/ui/pages/home/lullabies_tab.dart';
import 'package:babymoon/ui/pages/home/profile_tab.dart';
import 'package:babymoon/ui/pages/home/statistics_tab.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/ui/widgets/interstitial_ad.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 5,
    remindDays: 0,
    remindLaunches: 5,
  );

  PageController _pageController;
  int _currentPage;
  
  int _adCounter;

  Map<String, Widget> get _bottomItems => {
    'Home': Icon(Icons.home),
    'Statistics': Icon(Icons.insert_chart),
    'Lullabies': Icon(Icons.queue_music),
    'Profile': Icon(Icons.person)
  };

  BottomNavigationBarItem _bottomBarItem(String label, Widget icon) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: icon,
      title: Text(label)
    );
  }

  void _initializeRateMyApp() {
    _rateMyApp.init().then((_) {
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showStarRateDialog(
          context,
          title: 'Enjoying Babymoon?',
          message: 'Please leave a rating!',
          actionsBuilder: (context, stars) {
            return [
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  if (stars != null) {
                    _rateMyApp.save().then((v) => Navigator.pop(context));

                    if (stars <= 3) {
                      print('Navigate to Contact Us Screen');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => ContactUsScreen(),
                      //   ),
                      // );
                    } else if (stars <= 5) {
                      print('Leave a Review Dialog');
                      _rateMyApp.launchStore();
                    }
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ];
          },
          onDismissed: () => _rateMyApp
                            .callEvent(RateMyAppEventType.laterButtonPressed),
          dialogStyle: DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ),
          ignoreNativeDialog: Platform.isAndroid,
          starRatingOptions: StarRatingOptions(
            initialRating: 5.0,
            allowHalfRating: false,
            starsBorderColor: Colors.amber,
            starsFillColor: Colors.amber,
          ),
        );
      }
    });
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (c) => AboutDialog(
        children: [
          Text(
            'Icons provided by Icons8\n'
            "Lullabies provided by Johnson's baby\n\n"
            'Developed by Nonstapp',
            style: TextStyles.cardContentStyle,
            textAlign: TextAlign.start,
          )
        ],
      )
    );
  }

  void _showAd() async {

    final result = await showDialog(
      context: context,
      barrierColor: AppStyle.backgroundColor.withOpacity(0.8),
      barrierDismissible: false,
      builder: (context) => InterstitialAd(),
    );

    if (result != null) {
      if (result) {
        // Process payment
      } 
    }
  }

  void _changePage(int index) {
    //TODO: uncomment after handling remove ads
    // if (_adCounter % 2 == 0) {
    //   _showAd();
    // }
    _pageController.animateToPage(
      index, 
      duration: Duration(milliseconds: 150), 
      curve: Curves.easeInOut
    );
    _adCounter += 1;
  }

  @override
  void initState() {
    super.initState();
    _initializeRateMyApp();
    _adCounter = 0;
    _pageController = PageController(initialPage: 0);
    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.backgroundColor,
        title: Text(
          'Babymoon', 
          style: TextStyles.formTextStyle
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: AppStyle.accentColor),
            onPressed: _showAboutDialog,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/night.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => _currentPage = index),
          children: [
            HomeTab(),
            StatisticsTab(),
            LullabiesTab(),
            ProfileTab()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _changePage(index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppStyle.backgroundColor,
        selectedItemColor: AppStyle.accentColor,
        unselectedItemColor: AppStyle.unselectedColor,
        currentIndex: _currentPage,
        items: _bottomItems.keys.map((k) {
          return _bottomBarItem(k, _bottomItems[k]);
        }).toList()
      ),
    );
  }
}
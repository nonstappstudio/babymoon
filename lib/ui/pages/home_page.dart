import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/pages/home/home_tab.dart';
import 'package:babymoon/ui/pages/home/lullabies_tab.dart';
import 'package:babymoon/ui/pages/home/profile_tab.dart';
import 'package:babymoon/ui/pages/home/statistics_tab.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/utils/assets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController;
  int _currentPage;


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

  void _changePage(int index) {
    _pageController.animateToPage(
      index, 
      duration: Duration(milliseconds: 150), 
      curve: Curves.easeInOut
    );
  }

  @override
  void initState() {
    super.initState();
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
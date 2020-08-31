import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/pages/home/home_tab.dart';
import 'package:babymoon/ui/pages/home/statistics_tab.dart';
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
    'Library': Icon(Icons.library_books),
    'Profile': Icon(Icons.person)
  };

  BottomNavigationBarItem _bottomBarItem(String label, Widget icon) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: icon,
      title: Text(label)
    );
  }

  void _changePage(int index) {
    _pageController.animateToPage(
      index, 
      duration: Duration(milliseconds: 300), 
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
        title: Text('Babymoon'),
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
            Container(color: Colors.transparent, child: Center(child: Text('L'))),
            Container(color: Colors.transparent, child: Center(child: Text('P'))),
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
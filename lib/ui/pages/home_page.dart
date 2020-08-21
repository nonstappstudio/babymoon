import 'package:babymoon/ui/app_style.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController;
  int _currentPage;

  Map<String, Widget> get _bottomItems => {
    'Home': Icon(Icons.home),
    'Statistics': Icon(Icons.explore),
    'Library': Icon(Icons.library_add),
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
      backgroundColor: AppStyle.backgroundColor,
      appBar: CustomAppBar.getAppBar('Sleep Tracker', false),
      body: PageView(
        controller: _pageController,
        children: [
          Container(color: Colors.red),
          Container(color: Colors.blue)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _changePage(index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppStyle.backgroundColor,
        selectedItemColor: AppStyle.secondaryColor,
        unselectedItemColor: AppStyle.unselectedColor,
        currentIndex: _currentPage,
        items: _bottomItems.keys.map((k) {
          return _bottomBarItem(k, _bottomItems[k]);
        }).toList()
      ),
    );
  }
}
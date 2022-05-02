import 'package:flutter/material.dart';
import 'package:test/views/favourite.dart';
import 'package:test/views/search.dart';

import 'home.dart';

class DashboardScreen extends StatefulWidget {
  dynamic currentTab;
  Widget currentPage = HomeScreen();
  DashboardScreen({Key? key, this.currentTab}) {
    currentTab = 0;
  }

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // int? _currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _currentIndex = widget.currentTab as int;
  }

  @override
  Widget build(BuildContext context) {
     int _selectedIndex = 1;
    final _pageController = PageController(initialPage: 0);
    void _onItemTapped(int index) {
        // print("object");
      setState(() {
        _selectedIndex = index;
      });
      _pageController.animateToPage(index, duration: const Duration(microseconds: 300),curve: Curves.easeIn);
    }
    return Scaffold(
      backgroundColor:Colors.white,
      key: scaffoldKey,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          HomeScreen(),
          FavouriteScreen(),
          SearchScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

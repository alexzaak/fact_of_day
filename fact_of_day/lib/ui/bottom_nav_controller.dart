import 'package:fact_of_day/tabs/favorite_tab.dart';
import 'package:fact_of_day/tabs/start_tab.dart';
import 'package:flutter/material.dart';

import '../tabs/credits_tab.dart';

const String PAGE_KEY_START = "start_page";
const String PAGE_KEY_FAV = "fav_page";
const String PAGE_KEY_CREDIT = "credit_page";

class BottomNavigationBarController extends StatefulWidget {
  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final List<Widget> pages = [
    StartTab(key: PageStorageKey(PAGE_KEY_START)),
    FavoriteTab(key: PageStorageKey(PAGE_KEY_FAV)),
    CreditsTab(key: PageStorageKey(PAGE_KEY_CREDIT)),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).primaryTextTheme.headline6.color,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            title: Text('Facts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Credits'))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}

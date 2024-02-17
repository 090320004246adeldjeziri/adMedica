import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medical/main.dart';
import 'package:medical/pharma.dart';
import 'package:medical/setting.dart';

import 'footerNavBar.dart';

class MyDashBoard extends StatefulWidget {
  const MyDashBoard({super.key});

  @override
  _MyDashBoardState createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody(), bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 60,
      iconSize: 20,
      backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
      selectedIndex: _currentIndex,
      showElevation: false,
      itemCornerRadius: 24,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      curve: Curves.easeInCubic,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.apps),
          title: const Text('Home'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(
            Icons.search_outlined,
          ),
          title: const Text('Users'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.library_books_outlined),
          title: const Text(
            'Medicament Search ',
          ),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      MyHomePage(),
      // UsersPage(),
      Pharmacie(),
      Setting(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}

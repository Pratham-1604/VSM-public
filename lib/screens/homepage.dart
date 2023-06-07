// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:vsm/screens/power_cards_screen.dart';
import 'package:vsm/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/leaderboard.dart';
import 'home_screen.dart';

class HomePageLayout extends StatefulWidget {
  int _currPage;
  HomePageLayout(this._currPage, {super.key});

  @override
  State<HomePageLayout> createState() => _HomePageLayoutState();
}

class _HomePageLayoutState extends State<HomePageLayout> {
  final List<Map<String, dynamic>> _pages = [
    {
      'page': HomePage(),
      'title': 'Home Page',
    },
    {
      'page': PowerCardsScreen(),
      'title': 'Power Cards',
    },
    {
      'page': LeaderBoard(),
      'title': 'Leaderboard',
    },
    {
      'page': UserScreen(),
      'title': 'User',
    },
  ]; 
 

  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      widget._currPage = index;
      _pageController.jumpToPage(widget._currPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VSM'),
      ),
      body: PageView.builder(
        itemBuilder: (context, index) => _pages[index]['page'],
        itemCount: 4,
        // onPageChanged: (value) => {_pages[value]['page']},
        controller: _pageController,
        onPageChanged: (value) => setState(() {
          widget._currPage = value;
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        // backgroundColor: Color(0xFF03045E),

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.globe),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Color(0xFF03045E),
            icon: FaIcon(FontAwesomeIcons.boltLightning),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Color(0xFF03045E),
            icon: FaIcon(FontAwesomeIcons.chartSimple),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Color(0xFF03045E),
            icon: FaIcon(FontAwesomeIcons.userLarge),
            label: 'User',
          ),
        ],

        currentIndex: widget._currPage,
        onTap: _onItemTapped,
        // selectedItemColor: Colors.amber[800],
      ),
    );
  }
}

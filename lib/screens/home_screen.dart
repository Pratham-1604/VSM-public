// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:vsm/widgets/home_screen_item.dart';
import '../data/dummy_data.dart';
import '../data/colors.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      // bottomNavigationBar: ,// to do
      body: ListView.builder(
        itemCount: DummyData.dummyData.length,
        itemBuilder: (context, index) => Center(
          child: CardForStock(
            DummyData.dummyData[index]['name'] as String,
            DummyData.dummyData[index]['price'] as double,
            DummyData.dummyData[index]['quantity'] as double,
          ),
        ),
      ),

      // bottomNavigationBar: BottomNavBar(),
    );
  }
}

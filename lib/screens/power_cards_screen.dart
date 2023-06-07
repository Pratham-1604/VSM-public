// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import '../data/colors.dart';
import '../data/dummy_data.dart';
import '../widgets/powercard_item.dart';

class PowerCardsScreen extends StatelessWidget {
  const PowerCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      // bottomNavigationBar: ,// to do
      body: Column(
        children: [
          Text(
            'Powercards',
            style: TextStyle(
              fontSize: 30,
              color: CustomColors.textColor,
            ),
          ),
          // SizedBox(
          //   height: 5,
          // ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: DummyData.dummyData.length,
              itemBuilder: (context, index) => Center(
                child: PowerCardItem(
                  DummyData.imageLinks[index]['imagePath'] as String,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

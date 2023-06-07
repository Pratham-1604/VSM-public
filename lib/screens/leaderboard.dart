// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import '../widgets/leaderboard_item.dart';
import '../widgets/leaderboard_top3.dart';
import '../data/dummy_data.dart';
import '../data/colors.dart';

class LeaderBoard extends StatelessWidget {
  static const routeName = '/leaderboard';

  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LeaderboardTop3(),
          Expanded(
            child: Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              height: double.infinity,
              width: 350,
              child: ListView.builder(
                itemCount: DummyData.dummyLeaderboardData.length - 3,
                itemBuilder: (context, index) {
                  return LeaderboardItem(
                    index + 4,
                    DummyData.dummyLeaderboardData[index + 3]['name']
                        as String,
                    DummyData.dummyLeaderboardData[index + 3]['money']
                        as double,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}

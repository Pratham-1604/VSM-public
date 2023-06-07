// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:vsm/data/colors.dart';
import 'package:vsm/widgets/portfolio.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          children: [
            PortfolioWidget(),
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                height: 250,
                width: 300,
                child: Card(
                  color: CustomColors.cardBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 10,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Portfolio',
                        style: TextStyle(
                          color: CustomColors.textColor,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Paisa',
                        style: TextStyle(
                          color: CustomColors.textColor,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Leaderboard Rank',
                        style: TextStyle(
                          color: CustomColors.textColor,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '#1',
                        style: TextStyle(
                          color: CustomColors.textColor,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

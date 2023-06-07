// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import '../data/colors.dart';

class LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final double money;

  const LeaderboardItem(
    this.rank,
    this.name,
    this.money, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 61,
      child: Card(
        color: CustomColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 10,
        margin: EdgeInsets.all(5),
        child: SizedBox(
          height: 61,
          // width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$rank',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              // SizedBox(
              //   width: 30,
              // ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.textColor,
                ),
              ),
              Text(
                '$money',
                style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class PowerCardItem extends StatelessWidget {
  final String imagePath;
  const PowerCardItem(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 113,
      width: 303,
      margin: EdgeInsets.all(20),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

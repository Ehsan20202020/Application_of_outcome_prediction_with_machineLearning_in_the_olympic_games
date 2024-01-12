import 'package:flutter/material.dart';
import 'package:olympic_game_prediction/core/colors.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.greenAccent,
      ),
      child: Image.asset(imagePath),
      height: 70,
    );
  }
}

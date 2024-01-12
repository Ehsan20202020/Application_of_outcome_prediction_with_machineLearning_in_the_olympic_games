import 'package:flutter/material.dart';
import 'package:olympic_game_prediction/core/colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (context) => HomePage()));
      // },
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25), // 25
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: blackBG,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:olympic_game_prediction/core/colors.dart';

class Mainbutton extends StatelessWidget {
  //final Function() onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;
  final double? minWidth;
  final double? height;
  final double? radius;
  final String? textStr;

  const Mainbutton({
    Key? key,
    required this.onPressed,
    this.height,
    this.textColor,
    this.minWidth,
    this.radius,
    this.textStr,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      //   onPressed: () {},
      color: backgroundColor ?? AppColors.primaryColor,
      minWidth: minWidth,
      height: height ?? 45,
      textColor: textColor ?? AppColors.AppWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 0.0),
      ),
      child: Text(
        textStr ?? "",
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// class Mainbutton extends StatelessWidget {
//   final Function() onTap;
//   final String text;
//   final String? image;
//   final Color? txtColor;
//   final Color btnColor;
//   const Mainbutton({
//     Key? key,
//     required this.onTap,
//     required this.text,
//     this.image,
//     this.txtColor,
//     required this.btnColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 70.0,
//         margin: const EdgeInsets.symmetric(horizontal: 20.0),
//         decoration: BoxDecoration(
//           color: btnColor,
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (image != null)
//               Image.asset(
//                 'assets/image/$image',
//                 height: 25.0,
//                 width: 60.0,
//               ),
//             Text(
//               text,
//               style: txtColor != null
//                   ? headline2.copyWith(color: txtColor)
//                   : headline2,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

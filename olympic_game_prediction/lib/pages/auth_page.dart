















































// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:olympic_game_prediction/pages/Home_page.dart';
// import 'package:olympic_game_prediction/pages/log_in_page.dart';
// //import 'package:olympic_game_prediction/pages/login_or_register.dart';
// //import 'package:olympic_game_prediction/pages/login_page.dart';
// import 'package:olympic_game_prediction/pages/splash_Page.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           /// User is logged in
//           if (snapshot.hasData) {
//             return HomePage();
//           }

//           /// User is NOT loged in
//           else {
//             // return SplashPage();
//             return LogInPage2();
//           }
//         },
//       ),
//     );
//   }
// }

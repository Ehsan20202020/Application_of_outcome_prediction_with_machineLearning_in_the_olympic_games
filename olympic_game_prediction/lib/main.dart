import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:olympic_game_prediction/core/style.dart';
import 'package:olympic_game_prediction/pages/Home_page.dart';
//import 'package:olympic_game_prediction/pages/log_in_page.dart';
import 'package:olympic_game_prediction/pages/splash_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Game Prediction',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, Snapshot) {
            if (Snapshot.hasData) {
              return HomePage();
            } else {
              return SplashPage();
            }
          },
        ));
  }
}

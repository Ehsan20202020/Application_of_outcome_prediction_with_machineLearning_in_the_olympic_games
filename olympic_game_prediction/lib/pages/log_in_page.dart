import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olympic_game_prediction/components/my_button.dart';
import 'package:olympic_game_prediction/components/my_textfield.dart';
import 'package:olympic_game_prediction/components/square_tile.dart';
import 'package:olympic_game_prediction/core/colors.dart';
//import 'package:olympic_game_prediction/core/space.dart';
//import 'package:olympic_game_prediction/core/text_style.dart';
import 'package:olympic_game_prediction/pages/sign_up_page.dart';
//import 'package:olympic_game_prediction/widgets/main_button.dart';

class LogInPage2 extends StatefulWidget {
  const LogInPage2({super.key});

  @override
  State<LogInPage2> createState() => _LogInPage2State();
}

class _LogInPage2State extends State<LogInPage2> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Singn in User Method...
  void signUserIn() async {
    // Show loading circle...
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Try sign in ...
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Pop the dialog...
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop the dialog...
      Navigator.pop(context);

      //Wrong Email...
      if (e.code == "user-not-found") {
        // Show error to user...
        WrongEmailMessage();
      }
      //Wrong Password...
      else if (e.code == "wrong-password") {
        // Show error to user...

        WrongPasswordMessage();
      }
    }
  }

  // Wrong email message popup...
  void WrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorect Email!!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // Wrong Password message popup...
  void WrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Password!!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Icon(
                  Icons.lock,
                  size: 100,
                  // color: white,
                  color: Colors.blueGrey,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Welcome To my prediction app',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                ///******************** email TextField  ****************/
                MyTextField(
                  controller: emailController,
                  hintText: 'email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),

                ///******************** Password TextField  ****************/
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10,
                ),

                ///******************** Forget Password  ****************/
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15, ////25
                ),

                ///******************** Sign In Button  ****************/
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),

                const SizedBox(
                  height: 30,
                ),

                ///******************** or  ****************/
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                ///******************** google + apple sign in button  ****************/
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///******************** Google button  ****************/
                    SquareTile(imagePath: 'Images/google.png'),

                    SizedBox(
                      width: 25,
                    ),

                    ///******************** Apple button  ****************/
                    SquareTile(imagePath: 'Images/apple.png')
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: Container(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Not a Member? Register Now',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          size: 28,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olympic_game_prediction/components/my_button.dart';
import 'package:olympic_game_prediction/components/my_textfield.dart';
import 'package:olympic_game_prediction/components/square_tile.dart';
import 'package:olympic_game_prediction/core/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olympic_game_prediction/pages/log_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //Singn Up User Method...
  void signUserUp() async {
    // Show loading circle...
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //   // Try creating the user...
    //   try {
    //     //Check if password is confirmed...
    //     if (passwordController.text == confirmPasswordController.text) {
    //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //         email: emailController.text,
    //         password: passwordController.text,
    //       );
    //     } else {
    //       /// Show error message, password don't match
    //       showErrorMessage("Password don't match!");
    //     }

    //     // pop the loading circle..
    //     Navigator.pop(context);
    //   } on FirebaseAuthException catch (e) {
    //     // Pop the loadign circle...
    //     Navigator.pop(context);
    //     // Show error message...
    //     showErrorMessage(e.code);
    //   }
    // }

    try {
      // Check if password is confirmed...
      if (passwordController.text == confirmPasswordController.text) {
        // Create user with email and password
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Get the newly created user's UID
        final userUid = userCredential.user?.uid;

        // Store additional user data in Firestore
        if (userUid != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userUid)
              .set({
            'email': emailController.text,
            // Add more fields as needed
          });
        }
      } else {
        // Show error message, passwords don't match
        showErrorMessage("Passwords don't match!");
      }

      // Pop the loading circle...
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle...
      Navigator.pop(context);
      // Show error message...
      showErrorMessage(e.code);
    }
  }

  // Error Message to user...
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
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
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Icon(
              Icons.lock,
              size: 50,
              // color: white,
              color: Colors.blueGrey,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Lets create an account for you!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 25,
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

            ///******************** confirm Password TextField  ****************/
            MyTextField(
              controller: passwordController,
              hintText: 'Confirm Password',
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            ///******************** Sign In Button  ****************/
            MyButton(
              text: 'Sign Up',
              onTap: signUserUp,
            ),

            const SizedBox(
              height: 40,
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
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LogInPage2()));
              },
              child: Container(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Already Have an Account? Log in',
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
                      //  color: AppColors.primaryColor,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:olympic_game_prediction/core/app_assets.dart';
import 'package:olympic_game_prediction/core/app_radius.dart';
import 'package:olympic_game_prediction/core/colors.dart';
import 'package:olympic_game_prediction/pages/log_in_page.dart';
import 'package:olympic_game_prediction/pages/sign_up_page.dart';
import 'package:olympic_game_prediction/widgets/main_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(AppAssets.starterBGImage),
              colorFilter: ColorFilter.mode(
                  AppColors.primaryColor.withOpacity(0.5), BlendMode.darken),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.AppWhite,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(AppRadius.radius50),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Lets Predict the game... ',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Mainbutton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogInPage2()));
                      },
                      minWidth: width,
                      radius: AppRadius.radius8,
                      textStr: "Sign In",
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
                      splashColor: Colors.grey.withOpacity(0.3),
                      highlightColor: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(80),
                      child: Container(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Or Create An Account',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_right_alt,
                              size: 24,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}












// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   /// initially show login page...
//   bool showSplashPage = true;

//   // toggle between login and register page...

//   void togglePage() {
//     setState(() {
//       showSplashPage = !showSplashPage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: white,
//       body: Stack(
//         children: [
//           Container(
//             height: height,
//             color: blackBG,
//             child: Image.asset(
//               'Images/6.jpg',
//               height: height,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: height / 3,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: gradient,
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   RichText(
//                     text: const TextSpan(children: [
//                       TextSpan(
//                         text: 'Tokyo Olympics Game',
//                         style: headline,
//                       ),
//                       TextSpan(
//                         text: '.',
//                         style: headlineDot,
//                       ),
//                     ]),
//                   ),
//                   const SpaceVH(
//                     height: 15.0,
//                   ),
//                   const Text(
//                     ' As you know the Olympic Games are a very important event in the world of sports and the whole world. Lets predict which country will get the heighest number of medals.',
//                     textAlign: TextAlign.center,
//                     style: headline2,
//                   ),
//                   const SizedBox(
//                     height: 15.0,
//                   ),
//                   Mainbutton(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (builder) => LoginPage(
//                                     onTap: togglePage,
//                                   )));
//                     },
//                     btnColor: blueButton,
//                     text: 'Get Started',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

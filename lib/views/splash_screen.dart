import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dental_house/views/startup.dart';
import 'package:flutter/material.dart';
class splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.blue,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 550,
            height: 550,
            child: Image.asset("images/splash.png"),
          ),
        ],
      ),
      splashIconSize: 550,
      duration: 3000,
      nextScreen: startup(),
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: Duration(seconds: 2),
    );
  }
}
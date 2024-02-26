import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_cam/screens/home_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  get splashAnim => null;
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
            child: Center(
              child: LottieBuilder.asset(
                "assets/animation/splash.json",
              ),
            ),
          )
        ],
      ),
      nextScreen: const HomePage(),
      backgroundColor: Colors.white,
      splashIconSize: 400.0,
    );
  }
}

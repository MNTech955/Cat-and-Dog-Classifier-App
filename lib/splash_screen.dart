import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cat_and_dog_detector_app/home_screen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
     // pageTransitionType: ,
      animationDuration: const Duration(seconds: 4),
      splash: Image.asset("assets/dog.jpg"),
      splashIconSize: 200,
      backgroundColor: Colors.tealAccent,
      
       nextScreen: HomeScreen(),
       
       
       
       
       
       );
       
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marvelapp/screens/get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Start a timer of 5 seconds
    Timer(const Duration(seconds: 3), () {
      // After 5 seconds, navigate to the HomeScreen (or any screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const GetStartedScreen(), // Change to your target screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/jpg/splash-bg.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

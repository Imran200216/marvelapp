import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marvelapp/screens/bottom_nav.dart';
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
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    // Retrieve SharedPreferences instance
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the user is signed in as a guest or with email
    final bool isSignedInAsGuest = prefs.getBool('isSignedInAsGuest') ?? false;
    final bool isSignedIn = prefs.getBool('isLoggedIn') ?? false;

    final user = FirebaseAuth.instance.currentUser;

    // Determine where to navigate
    Timer(const Duration(seconds: 3), () {
      if (isSignedInAsGuest || (user != null && isSignedIn)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const GetStartedScreen(),
          ),
        );
      }
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

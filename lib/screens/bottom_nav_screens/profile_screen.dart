import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Text(
            "Profile screen",
            style: TextStyle(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

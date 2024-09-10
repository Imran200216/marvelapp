import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';

class SuperHeroScreen extends StatelessWidget {
  const SuperHeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Text(
            "Super hero screen",
            style: TextStyle(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

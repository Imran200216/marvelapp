import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            top: 30,
            right: 20,
            bottom: 30,
          ),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}

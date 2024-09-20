import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marvelapp/constants/colors.dart';

class InternetCheckerContent extends StatelessWidget {
  const InternetCheckerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 4,
          ),
          Lottie.asset(
            'assets/images/animation/robot-animation.json',
            height: size.height * 0.3,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            "Connection error",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: size.width * 0.050,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            child: Text(
              textAlign: TextAlign.center,
              "It seems you aren't connected to the internet. Try checking your connection or switching between Wi-Fi and cellular data.",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: size.width * 0.036,
                fontWeight: FontWeight.w500,
                color: AppColors.subTitleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import 'package:marvelapp/constants/colors.dart';

class MyDownloadScreen extends StatelessWidget {
  const MyDownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  "assets/images/svg/back-icon.svg",
                  height: size.height * 0.05,
                  width: size.width * 0.05,
                  fit: BoxFit.cover,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                "My Downloads",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: size.width * 0.050,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 40,
                      ),
                      child: Lottie.asset(
                        "assets/images/animation/no-download-animation.json",
                        height: size.height * 0.3,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "No downloads found",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size.width * 0.036,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

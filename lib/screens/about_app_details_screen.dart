import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';

class AboutAppDetailsScreen extends StatelessWidget {
  const AboutAppDetailsScreen({super.key});

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
              Text(
                "Explore the Marvel Universe",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: size.width * 0.050,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

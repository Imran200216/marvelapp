import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/screens/bottom_nav.dart';

import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class UserGuestNicknameDetailsScreen extends StatelessWidget {
  const UserGuestNicknameDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting the size of the screen

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Cool Nick names\nfor your profile",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: size.width * 0.060,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),

              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter your text here',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.subTitleColor,
                    fontSize: 14,
                    fontFamily: "Poppins",
                  ),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontFamily: "Poppins",
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),

              /// all set btn
              NeoPopButton(
                color: AppColors.secondaryColor,
                onTapUp: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return BottomNavBar();
                  }));
                },
                onTapDown: () => HapticFeedback.vibrate(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/svg/next-icon.svg",
                        height: MediaQuery.of(context).size.height * 0.030,
                        width: MediaQuery.of(context).size.width * 0.030,
                        color: AppColors.primaryColor,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Text(
                        "All Set",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.038,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

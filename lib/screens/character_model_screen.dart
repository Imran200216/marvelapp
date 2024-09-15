import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';

class CharacterModelScreen extends StatelessWidget {
  const CharacterModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            gradient: LinearGradient(
              colors: [
                Color(0xFFD10C25),
                Color(0xFF991520),
              ],
              stops: [
                0.2,
                0.7,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          top: 16,
                        ),
                        child: SvgPicture.asset(
                          "assets/images/svg/back-icon.svg",
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          fit: BoxFit.cover,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Iron Man",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: size.width * 0.060,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        Text(
                          "Robert downey JR",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: size.width * 0.044,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFEDACB2),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

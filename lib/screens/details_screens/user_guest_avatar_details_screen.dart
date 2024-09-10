import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/screens/details_screens/user_guest_nickname_details_screen.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class UserGuestAvatarDetailsScreen extends StatelessWidget {
  const UserGuestAvatarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting the size of the screen
    final size = MediaQuery.of(context).size;
    final List<String> imageList = [
      'https://imgs.search.brave.com/yFLPbMIn1BcTxuf2Sqm0lzSzvXIsfTju2QOAnbQ-buk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzQzLzkwLzM3/LzM2MF9GXzQzOTAz/NzMyX1gxWjJnenk0/OTdhaXNnTUU2MmNy/bVUwMFNmOHNtUDU5/LmpwZw',
      'https://imgs.search.brave.com/MZJ3Rh6-84l52fdAbb9EePP-s8OJWzl2iT7IF0Gc1Nc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9idXJz/dC5zaG9waWZ5Y2Ru/LmNvbS9waG90b3Mv/dGhhaWxhbmQtYmVh/Y2guanBnP3dpZHRo/PTEwMDAmZm9ybWF0/PXBqcGcmZXhpZj0w/JmlwdGM9MA',
      'https://imgs.search.brave.com/yFLPbMIn1BcTxuf2Sqm0lzSzvXIsfTju2QOAnbQ-buk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAwLzQzLzkwLzM3/LzM2MF9GXzQzOTAz/NzMyX1gxWjJnenk0/OTdhaXNnTUU2MmNy/bVUwMFNmOHNtUDU5/LmpwZw',
      'https://imgs.search.brave.com/MZJ3Rh6-84l52fdAbb9EePP-s8OJWzl2iT7IF0Gc1Nc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9idXJz/dC5zaG9waWZ5Y2Ru/LmNvbS9waG90b3Mv/dGhhaWxhbmQtYmVh/Y2guanBnP3dpZHRo/PTEwMDAmZm9ybWF0/PXBqcGcmZXhpZj0w/JmlwdGM9MA',
    ];

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
              Text(
                "Add Cool Avatars\nfor your profile",
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
              Center(
                child: DottedBorder(
                  borderType: BorderType.Circle,
                  dashPattern: const [6, 6],
                  color: Colors.grey.shade200,
                  strokeWidth: 2,
                  child: Container(
                    width: size.width * 0.42,
                    height: size.width * 0.42,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/png/avatar-bg-img.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),

              /// cool avatars from database
              CarouselSlider(
                options: CarouselOptions(
                  height: size.height * 0.30,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 0.8,
                ),
                items: imageList
                    .map((item) => Container(
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),

              /// avatar next btn
              NeoPopButton(
                color: AppColors.secondaryColor,
                onTapUp: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const UserGuestNicknameDetailsScreen();
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
                        "Next",
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

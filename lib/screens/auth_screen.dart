import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/screens/dummy_screen.dart';

import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// image container
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.zero,
              ),
              child: CachedNetworkImage(
                imageUrl:
                    "https://imgs.search.brave.com/7xjVccJwldC3bNmJGegvBpRz2L8pmwwSc8BO7NzZuRQ/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvZmVhdHVy/ZWQvYXZlbmdlcnMt/dm0xNnh2NGE2OXNt/ZGF1eS5qcGc",
                placeholder: (context, url) => Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: AppColors.secondaryColor,
                ),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),

            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore the Marvel Universe",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: MediaQuery.of(context).size.width * 0.050,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "Include facts about their origin stories, powers, alliances, enemies, and key moments in Marvel history.",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: MediaQuery.of(context).size.width * 0.038,
                      fontWeight: FontWeight.w500,
                      color: AppColors.subTitleColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  NeoPopButton(
                    color: Colors.black,
                    onTapUp: () => HapticFeedback.vibrate(),
                    onTapDown: () => HapticFeedback.vibrate(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/svg/mail-auth-icon.svg",
                            height: MediaQuery.of(context).size.height * 0.030,
                            width: MediaQuery.of(context).size.width * 0.030,
                            color: AppColors.secondaryColor,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Text(
                            "Sign in with Email",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.038,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  NeoPopButton(
                    color: Colors.black,
                    onTapUp: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const DummyScreen();
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
                            "assets/images/svg/guest-auth-icon.svg",
                            height: MediaQuery.of(context).size.height * 0.030,
                            width: MediaQuery.of(context).size.width * 0.030,
                            color: AppColors.secondaryColor,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Text(
                            "Sign in with Guest",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.038,
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
          ],
        ),
      ),
    );
  }
}

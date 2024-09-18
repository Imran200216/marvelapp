import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/authentication_providers/guest_auth_provider.dart';

import 'package:marvelapp/screens/email_auth_screen/email_login_screen.dart';
import 'package:marvelapp/widgets/custom_neopop_btn.dart';

import 'package:provider/provider.dart';

class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.secondaryColor,
          body: Consumer<GuestAuthenticationProvider>(
            builder: (
              context,
              guestAuthProvider,
              child,
            ) {
              return Column(
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

                        /// login in with email btn
                        CustomNeoPopButton(
                          buttonColor: AppColors.primaryColor,
                          svgColor: AppColors.secondaryColor,
                          svgAssetPath: "assets/images/svg/mail-auth-icon.svg",
                          buttonText: "Sign in with Email",
                          onTapUp: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const EmailLoginScreen();
                            }));
                          },
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),

                        /// sign in with guest btn
                        guestAuthProvider.isLoading
                            ? Center(
                                child: LoadingAnimationWidget.threeArchedCircle(
                                  color: AppColors.primaryColor,
                                  size: 40,
                                ),
                              )
                            : CustomNeoPopButton(
                                buttonColor: AppColors.primaryColor,
                                svgColor: AppColors.secondaryColor,
                                svgAssetPath:
                                    "assets/images/svg/guest-auth-icon.svg",
                                buttonText: "Sign in with Guest",
                                onTapUp: () {
                                  /// sign in with guest
                                  guestAuthProvider.signInWithGuest(context);
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

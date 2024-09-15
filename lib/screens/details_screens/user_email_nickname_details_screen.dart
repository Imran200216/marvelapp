import 'package:flutter/material.dart';

import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/user_details_provider/email_user_details_provider.dart';

import 'package:marvelapp/widgets/custom_neopop_btn.dart';
import 'package:marvelapp/widgets/custom_textfield.dart';

import 'package:provider/provider.dart';

class UserEmailNicknameDetailsScreen extends StatelessWidget {
  const UserEmailNicknameDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Consumer<EmailUserDetailsProvider>(
          builder: (
            context,
            emailUserProvider,
            child,
          ) {
            return Container(
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
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  // Custom TextField for Nickname, now controlled by the provider
                  CustomTextField(
                    textEditingController:
                        emailUserProvider.nicknameControllerByEmail,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.person,
                    hintText: 'Enter your nickname',
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  // All set button
                  CustomNeoPopButton(
                    buttonColor: AppColors.secondaryColor,
                    svgColor: AppColors.primaryColor,
                    svgAssetPath: "assets/images/svg/next-icon.svg",
                    buttonText: "All Set",
                    onTapUp: () {
                      // Call setNickname from the provider to update Fire store
                      emailUserProvider
                          .setNickname(context)
                          .catchError((error) {
                        // Handle errors if updating nickname fails
                        print("Failed to update nickname: $error");
                      });

                      /// clearing text editing controller
                      emailUserProvider.nicknameControllerByEmail.clear();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/authentication_providers/email_auth_provider.dart';
import 'package:marvelapp/widgets/custom_neopop_btn.dart';

import 'package:marvelapp/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DoubleTapToExit(
      snackBar: SnackBar(
        backgroundColor: AppColors.timeLineBgColor,
        content: Text(
          "Tag again to exit!",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: size.width * 0.040,
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Consumer<EmailAuthenticationProvider>(
            builder: (
              context,
              emailAuthProvider,
              child,
            ) {
              return Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 30,
                  right: 20,
                  bottom: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.secondaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.001,
                        ),
                        Text(
                          "Forget Password",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: MediaQuery.of(context).size.width * 0.050,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    const CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      hintText: 'Email address',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                    ),
                    CustomNeoPopButton(
                      buttonColor: AppColors.secondaryColor,
                      svgColor: AppColors.primaryColor,
                      svgAssetPath: "assets/images/svg/login-icon.svg",
                      buttonText: "Send link",
                      onTapUp: () {
                        /// reset password
                        emailAuthProvider.resetPassword(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

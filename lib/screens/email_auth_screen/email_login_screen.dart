import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/authentication_providers/email_auth_provider.dart';
import 'package:marvelapp/screens/email_auth_screen/email_register_screen.dart';
import 'package:marvelapp/screens/email_auth_screen/forget_password_screen.dart';
import 'package:marvelapp/widgets/custom_neopop_btn.dart';
import 'package:marvelapp/widgets/custom_password_textfield.dart';
import 'package:marvelapp/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                right: 20,
                top: 30,
                bottom: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login your account!",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: MediaQuery.of(context).size.width * 0.050,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),

                  /// email field
                  CustomTextField(
                    textEditingController:
                        emailAuthProvider.loginEmailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    hintText: 'Email address',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),

                  /// password field
                  CustomPasswordTextField(
                    textEditingController:
                        emailAuthProvider.loginPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Password",
                    fieldKey: "passwordField",
                    prefixIcon: Icons.password,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ForgetPasswordScreen();
                          }));
                        },
                        child: Text(
                          "Forget password?",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                            fontSize: MediaQuery.of(context).size.width * 0.040,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                  emailAuthProvider.isLoading
                      ? Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: AppColors.secondaryColor,
                            size: 40,
                          ),
                      )
                      : CustomNeoPopButton(
                          buttonColor: AppColors.secondaryColor,
                          svgColor: AppColors.primaryColor,
                          svgAssetPath: "assets/images/svg/login-icon.svg",
                          buttonText: "Login",
                          onTapUp: () {
                            /// email login
                            emailAuthProvider.loginWithEmailPassword(context);
                          },
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Create an account?",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor,
                          fontSize: MediaQuery.of(context).size.width * 0.038,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const EmailRegisterScreen();
                          }));
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                            fontSize: MediaQuery.of(context).size.width * 0.040,
                          ),
                        ),
                      ),
                    ],
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

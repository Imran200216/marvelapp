import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/authentication_providers/email_auth_provider.dart';
import 'package:marvelapp/screens/email_auth_screen/email_login_screen.dart';
import 'package:marvelapp/widgets/custom_neopop_btn.dart';
import 'package:marvelapp/widgets/custom_password_textfield.dart';
import 'package:marvelapp/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class EmailRegisterScreen extends StatelessWidget {
  const EmailRegisterScreen({super.key});

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
                    "Create your account!",
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

                  /// username field
                  const CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    hintText: 'Username',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  /// email field
                  const CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    hintText: 'Email address',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  /// password field
                  const CustomPasswordTextField(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Password",
                    fieldKey: "passwordFieldRegister",
                    prefixIcon: Icons.password,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  /// confirm password field
                  const CustomPasswordTextField(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Confirm Password",
                    fieldKey: "passwordFieldRegister",
                    prefixIcon: Icons.password,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                  CustomNeoPopButton(
                    buttonColor: AppColors.secondaryColor,
                    svgColor: AppColors.primaryColor,
                    svgAssetPath: "assets/images/svg/login-icon.svg",
                    buttonText: "Register",
                    onTapUp: () {
                      /// email register
                      emailAuthProvider.registerWithEmailPassword(context);
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
                        "Already have an account?",
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
                            return const EmailLoginScreen();
                          }));
                        },
                        child: Text(
                          "Login",
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

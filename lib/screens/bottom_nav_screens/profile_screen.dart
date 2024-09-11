import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/authentication_providers/email_auth_provider.dart';
import 'package:marvelapp/provider/authentication_providers/guest_auth_provider.dart';
import 'package:marvelapp/widgets/custom_listile.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          margin: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "My account",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.width * 0.044,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColor,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),

              /// Profile picture
              Container(
                height: MediaQuery.of(context).size.height * 0.16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1726005442684-9debd8b3c158?q=80&w=1469&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),

              /// Personal info section wrapped in a scrollable widget
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: AppColors.primaryColor,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.timeLineBgColor,
                        width: 0.5, // The width of the top border
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Personal info",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: MediaQuery.of(context).size.width * 0.034,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        CustomListile(
                          svgAssetLeading:
                              "assets/images/svg/profile-outlined-icon.svg",
                          title: "Your name",
                          subTitle: user!.displayName ?? "No name",
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomListile(
                          svgAssetLeading:
                              "assets/images/svg/nickname-outlined-icon.svg",
                          title: "Your nickname",
                          subTitle: "Thanos",
                          onTap: () {},
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        user.isAnonymous
                            ? const SizedBox()
                            : CustomListile(
                                svgAssetLeading:
                                    "assets/images/svg/email-outlined-icon.svg",
                                title: "Email address",
                                subTitle: user.email ?? "No one authenticated",
                              ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        CustomListile(
                          svgAssetLeading: "assets/images/svg/signout-icon.svg",
                          title: "Sign out",
                          subTitle: "Easy sign out",
                          onTap: () async {
                            if (user != null) {
                              if (user.isAnonymous) {
                                // User is signed in as guest
                                final guestProvider =
                                    Provider.of<GuestAuthenticationProvider>(
                                        context,
                                        listen: false);
                                await guestProvider.signOutWithGuest(context);
                              } else {
                                // User is signed in with email
                                final emailProvider =
                                    Provider.of<EmailAuthenticationProvider>(
                                        context,
                                        listen: false);
                                await emailProvider.signOut(context);
                              }
                            } else {
                              // No user is signed in
                              ToastHelper.showErrorToast(
                                context: context,
                                message: "No user is currently signed in.",
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_version_provider.dart';
import 'package:marvelapp/provider/authentication_providers/email_auth_provider.dart';
import 'package:marvelapp/provider/authentication_providers/guest_auth_provider.dart';

import 'package:marvelapp/provider/user_details_provider/email_user_details_provider.dart';
import 'package:marvelapp/provider/user_details_provider/guest_user_details_provider.dart';
import 'package:marvelapp/screens/about_app_details_screen.dart';
import 'package:marvelapp/screens/profile_edit_screens/profile_avatar_edit_email_screen.dart';
import 'package:marvelapp/screens/profile_edit_screens/profile_avatar_edit_guest_screen.dart';

import 'package:marvelapp/widgets/custom_listile.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Fetch guest user details when the widget is built
    if (user != null && user.isAnonymous) {
      Provider.of<GuestUserDetailsProvider>(context, listen: false)
          .fetchGuestUserDetails();
    } else {
      Provider.of<EmailUserDetailsProvider>(context, listen: false)
          .fetchEmailUserDetails();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Consumer3<GuestUserDetailsProvider, EmailUserDetailsProvider,
            AppVersionProvider>(
          builder: (
            context,
            guestUserProvider,
            emailUserProvider,
            appVersionProvider,
            child,
          ) {
            return Container(
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

                  user!.isAnonymous
                      ? Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.16,
                              width: MediaQuery.of(context).size.height * 0.16,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: guestUserProvider.avatarPhotoURL ??
                                      "https://example.com/default-avatar.png",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const ProfileAvatarEditGuestScreen();
                                  }));
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.editContainerBgColor,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/images/svg/edit-outlined-icon.svg",
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.cover,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.16,
                              width: MediaQuery.of(context).size.height * 0.16,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: emailUserProvider.avatarPhotoURL ??
                                      "https://imgs.search.brave.com/hjo8zDIxlTqf_jwu_RxiKpSQpyauoiJ7Pbx8m7HVNfg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by91/c2VyLXByb2ZpbGUt/aWNvbi1mcm9udC1z/aWRlLXdpdGgtd2hp/dGUtYmFja2dyb3Vu/ZF8xODcyOTktNDAw/MTAuanBnP3NpemU9/NjI2JmV4dD1qcGc",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const ProfileAvatarEditEmailScreen();
                                  }));
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.editContainerBgColor,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/images/svg/edit-outlined-icon.svg",
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.cover,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                          children: [
                            Text(
                              "Personal info",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.034,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),

                            /// name
                            user.isAnonymous
                                ? const SizedBox()
                                : CustomListile(
                                    svgAssetLeading:
                                        "assets/images/svg/profile-outlined-icon.svg",
                                    title: "Your name",
                                    subTitle: user.displayName ?? "No name",
                                    trailing: const SizedBox(),
                                  ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),

                            /// nick name
                            user.isAnonymous
                                ? CustomListile(
                                    svgAssetLeading:
                                        "assets/images/svg/nickname-outlined-icon.svg",
                                    title: "Your nickname",
                                    subTitle: guestUserProvider.nickname ??
                                        "No nickname",
                                    trailing: const SizedBox(),
                                  )
                                : CustomListile(
                                    svgAssetLeading:
                                        "assets/images/svg/nickname-outlined-icon.svg",
                                    title: "Your nickname",
                                    subTitle: emailUserProvider.nickname ??
                                        "No nickname",
                                    trailing: const SizedBox(),
                                  ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),

                            /// email address
                            user.isAnonymous
                                ? const SizedBox()
                                : CustomListile(
                                    svgAssetLeading:
                                        "assets/images/svg/email-outlined-icon.svg",
                                    title: "Email address",
                                    subTitle:
                                        user.email ?? "No one authenticated",
                                    trailing: const SizedBox(),
                                  ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),

                            /// app version
                            CustomListile(
                              svgAssetLeading:
                                  "assets/images/svg/version-icon.svg",
                              title: 'App Version',
                              subTitle: appVersionProvider.appVersion,
                              trailing: const SizedBox(),
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),

                            /// about app
                            CustomListile(
                              svgAssetLeading:
                                  "assets/images/svg/about-icon.svg",
                              title: "About app",
                              subTitle: "App Info",
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AboutAppDetailsScreen();
                                }));
                              },
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),

                            /// sign out
                            CustomListile(
                              svgAssetLeading:
                                  "assets/images/svg/signout-icon.svg",
                              title: "Sign out",
                              subTitle: "Easy sign out",
                              onTap: () async {
                                if (user != null) {
                                  if (user.isAnonymous) {
                                    // User is signed in as guest
                                    final guestProvider = Provider.of<
                                            GuestAuthenticationProvider>(
                                        context,
                                        listen: false);
                                    await guestProvider
                                        .signOutWithGuest(context);
                                  } else {
                                    // User is signed in with email
                                    final emailProvider = Provider.of<
                                            EmailAuthenticationProvider>(
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
            );
          },
        ),
      ),
    );
  }
}

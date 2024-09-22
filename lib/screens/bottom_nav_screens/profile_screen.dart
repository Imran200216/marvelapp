import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_required_providers/app_version_provider.dart';
import 'package:marvelapp/provider/app_required_providers/in_app_review_provider.dart';
import 'package:marvelapp/provider/authentication_providers/email_auth_provider.dart';
import 'package:marvelapp/provider/authentication_providers/guest_auth_provider.dart';
import 'package:marvelapp/provider/user_details_provider/email_user_details_provider.dart';
import 'package:marvelapp/provider/user_details_provider/guest_user_details_provider.dart';
import 'package:marvelapp/screens/about_app_details_screen.dart';
import 'package:marvelapp/widgets/custom_listile.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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
        body: Consumer6<
            GuestUserDetailsProvider,
            EmailUserDetailsProvider,
            AppVersionProvider,
            InAppReviewProvider,
            EmailAuthenticationProvider,
            GuestAuthenticationProvider>(
          builder: (
            context,
            guestUserProvider,
            emailUserProvider,
            appVersionProvider,
            reviewProvider,
            emailAuthProvider,
            guestAuthProvider,
            child,
          ) {
            return LiquidPullToRefresh(
              showChildOpacityTransition: true,
              onRefresh: () async {
                // Refresh guest or email user details based on the current user type
                if (user != null && user.isAnonymous) {
                  await Provider.of<GuestUserDetailsProvider>(context,
                          listen: false)
                      .fetchGuestUserDetails();
                } else {
                  await Provider.of<EmailUserDetailsProvider>(context,
                          listen: false)
                      .fetchEmailUserDetails();
                }
              },
              color: AppColors.timeLineBgColor,
              backgroundColor: AppColors.pullToRefreshBgColor,
              child: Container(
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
                        ? AvatarGlow(
                            startDelay: const Duration(microseconds: 1000),
                            repeat: true,
                            glowRadiusFactor: 0.12,
                            child: Material(
                              elevation: 0.1,
                              shape: const CircleBorder(),
                              color: AppColors.avatarGlowColor,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                width:
                                    MediaQuery.of(context).size.height * 0.16,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: guestUserProvider
                                            .avatarPhotoURL ??
                                        "https://i.pinimg.com/564x/39/51/fa/3951fa4087ca2e4e75dd9a954722ed77.jpg",
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
                            ),
                          )
                        : AvatarGlow(
                            startDelay: const Duration(microseconds: 1000),
                            repeat: true,
                            glowRadiusFactor: 0.12,
                            child: Material(
                              elevation: 0.1,
                              shape: const CircleBorder(),
                              color: AppColors.avatarGlowColor,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                width:
                                    MediaQuery.of(context).size.height * 0.16,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: emailUserProvider
                                            .avatarPhotoURL ??
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
                                height:
                                    MediaQuery.of(context).size.height * 0.026,
                              ),

                              /// name
                              user.isAnonymous
                                  ? const SizedBox.shrink()
                                  : CustomListTile(
                                      svgAssetLeading:
                                          "assets/images/svg/profile-outlined-icon.svg",
                                      title: "Your name",
                                      subTitle: user.displayName ?? "No name",
                                      trailing: const SizedBox(),
                                    ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),

                              /// nick name
                              user.isAnonymous
                                  ? CustomListTile(
                                      svgAssetLeading:
                                          "assets/images/svg/nickname-outlined-icon.svg",
                                      title: "Your nickname",
                                      subTitle: guestUserProvider.nickname ??
                                          "No nickname",
                                      trailing: const SizedBox(),
                                    )
                                  : CustomListTile(
                                      svgAssetLeading:
                                          "assets/images/svg/nickname-outlined-icon.svg",
                                      title: "Your nickname",
                                      subTitle: emailUserProvider.nickname ??
                                          "No nickname",
                                      trailing: const SizedBox(),
                                    ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),

                              /// email address
                              user.isAnonymous
                                  ? const SizedBox.shrink()
                                  : CustomListTile(
                                      svgAssetLeading:
                                          "assets/images/svg/email-outlined-icon.svg",
                                      title: "Email address",
                                      subTitle:
                                          user.email ?? "No one authenticated",
                                      trailing: const SizedBox(),
                                    ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),

                              /// app version
                              CustomListTile(
                                svgAssetLeading:
                                    "assets/images/svg/version-icon.svg",
                                title: 'App Version',
                                subTitle: appVersionProvider.appVersion,
                                trailing: const SizedBox(),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),

                              /// share app
                              CustomListTile(
                                svgAssetLeading:
                                    "assets/images/svg/share-icon.svg",
                                title: "Share app",
                                subTitle: "Share app to your marvel fans",
                                onTap: () async {
                                  /// share functionality
                                  final result = await Share.share(
                                      'https://play.google.com/store/apps/details?id=com.example.marvelapp');

                                  if (result.status ==
                                      ShareResultStatus.success) {
                                    ToastHelper.showSuccessToast(
                                        context: context,
                                        message: "Thanks for sharing");
                                  } else {
                                    ToastHelper.showErrorToast(
                                        context: context,
                                        message: "Something went wrong");
                                  }
                                },
                              ),

                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),

                              /// in app review
                              user.isAnonymous
                                  ? guestAuthProvider.guestUser?.hasReviewed ==
                                          true
                                      ? const SizedBox.shrink()
                                      : CustomListTile(
                                          svgAssetLeading:
                                              "assets/images/svg/ratings-logo-icon.svg",
                                          title: "App Review",
                                          subTitle:
                                              "Make a review that helps us grow",
                                          onTap: () async {
                                            /// Trigger the app review
                                            await reviewProvider
                                                .triggerInAppReview(context);
                                            await guestAuthProvider
                                                .submitReview(context);
                                          },
                                        )
                                  : (!emailAuthProvider.hasReviewed)
                                      ? CustomListTile(
                                          svgAssetLeading:
                                              "assets/images/svg/ratings-logo-icon.svg",
                                          title: "App Review",
                                          subTitle:
                                              "Make a review that helps us grow",
                                          onTap: () async {
                                            /// Trigger the app review
                                            await reviewProvider
                                                .triggerInAppReview(context);
                                            await emailAuthProvider
                                                .submitReview(context);
                                          },
                                        )
                                      : const SizedBox.shrink(),

                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),

                              /// about app
                              CustomListTile(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),

                              /// sign out
                              CustomListTile(
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
                                      message:
                                          "No user is currently signed in.",
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
            );
          },
        ),
      ),
    );
  }
}

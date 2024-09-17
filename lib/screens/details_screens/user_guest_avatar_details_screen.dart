import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/user_details_provider/guest_user_details_provider.dart';
import 'package:marvelapp/screens/details_screens/user_guest_nickname_details_screen.dart';
import 'package:marvelapp/widgets/custom_neopop_btn.dart';
import 'package:provider/provider.dart';

class UserGuestAvatarDetailsScreen extends StatefulWidget {
  const UserGuestAvatarDetailsScreen({super.key});

  @override
  _UserGuestAvatarDetailsScreenState createState() =>
      _UserGuestAvatarDetailsScreenState();
}

class _UserGuestAvatarDetailsScreenState
    extends State<UserGuestAvatarDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch avatars when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userGuestDetailsProvider =
          Provider.of<GuestUserDetailsProvider>(context, listen: false);
      if (userGuestDetailsProvider.imageUrls.isEmpty) {
        userGuestDetailsProvider.fetchAvatars();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userGuestDetailsProvider =
        Provider.of<GuestUserDetailsProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomSheet: userGuestDetailsProvider.isAvatarUpdated
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.zero,
                  color: AppColors.primaryColor,
                ),
                child: CustomNeoPopButton(
                  buttonColor: AppColors.secondaryColor,
                  svgColor: AppColors.primaryColor,
                  svgAssetPath: 'assets/images/svg/next-icon.svg',
                  buttonText: 'Next',
                  onTapUp: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const UserGuestNicknameDetailsScreen();
                    }));
                  },
                ),
              )
            : const SizedBox(),
        body: LiquidPullToRefresh(
          showChildOpacityTransition: true,
          onRefresh: () async {
            await userGuestDetailsProvider.fetchAvatars();
          },
          color: AppColors.timeLineBgColor,
          backgroundColor: AppColors.pullToRefreshBgColor,
          child: Container(
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
                SizedBox(height: size.height * 0.05),
                Center(
                  child: DottedBorder(
                    borderType: BorderType.Circle,
                    dashPattern: const [6, 6],
                    color: Colors.grey.shade200,
                    strokeWidth: 2,
                    child: Container(
                      width: size.width * 0.42,
                      height: size.width * 0.42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: userGuestDetailsProvider.selectedAvatarURL !=
                                  null
                              ? CachedNetworkImageProvider(
                                  userGuestDetailsProvider.selectedAvatarURL!)
                              : const AssetImage(
                                  "assets/images/png/avatar-bg-img.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                userGuestDetailsProvider.imageUrls.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.02),
                            Lottie.asset(
                              'assets/images/animation/empty-animation.json',
                              height: size.height * 0.3,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              'Loading, Lets have some fun!',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.040,
                                fontFamily: "Poppins",
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          itemCount: userGuestDetailsProvider.imageUrls.length,
                          itemBuilder: (context, index) {
                            final avatarUrl =
                                userGuestDetailsProvider.imageUrls[index];

                            return InkWell(
                              onTap: () {
                                userGuestDetailsProvider.setSelectedAvatar(
                                    avatarUrl, context);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: avatarUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child:
                                          LoadingAnimationWidget.dotsTriangle(
                                        color: AppColors.secondaryColor,
                                        size: 40,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(height: size.height * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

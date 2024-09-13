import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/user_details_provider/email_user_details_provider.dart';

import 'package:marvelapp/screens/details_screens/user_email_nickname_details_screen.dart';
import 'package:marvelapp/widgets/custom_neopop_btn.dart';
import 'package:provider/provider.dart';

class UserEmailAvatarDetailsScreen extends StatelessWidget {
  const UserEmailAvatarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Fetch avatars from provider
    final userEmailDetailsProvider =
        Provider.of<EmailUserDetailsProvider>(context);

    // Trigger fetch if imageUrls is empty
    if (userEmailDetailsProvider.imageUrls.isEmpty) {
      userEmailDetailsProvider.fetchAvatars();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  return const UserEmailNicknameDetailsScreen();
                }));
              },
            )),
        body: Container(
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
              SizedBox(
                height: size.height * 0.05,
              ),
              // Display selected avatar in dotted border
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
                        image: userEmailDetailsProvider.selectedAvatarURL !=
                                null
                            ? CachedNetworkImageProvider(
                                userEmailDetailsProvider.selectedAvatarURL!)
                            : const CachedNetworkImageProvider(
                                "https://i.pinimg.com/564x/cb/24/dc/cb24dcc240159a21891028e1d2eaa002.jpg"),
                        // Placeholder image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),

              /// Grid view for cool avatars
              userEmailDetailsProvider.imageUrls.isEmpty
                  ? Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                        color: AppColors.primaryColor,
                        size: 40,
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
                        itemCount: userEmailDetailsProvider.imageUrls.length,
                        itemBuilder: (context, index) {
                          final avatarUrl =
                              userEmailDetailsProvider.imageUrls[index];

                          return InkWell(
                            onTap: () {
                              // Update the selected avatar in provider and Firebase
                              userEmailDetailsProvider.setSelectedAvatar(
                                  avatarUrl, context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      userEmailDetailsProvider.imageUrls[index],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: LoadingAnimationWidget.dotsTriangle(
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
              SizedBox(
                height: size.height * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

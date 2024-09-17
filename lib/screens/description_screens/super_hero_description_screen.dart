import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/db_provider/super_hero_character_db_provider.dart';
import 'package:marvelapp/screens/character_model_screen.dart';
import 'package:marvelapp/screens/video_player_screen.dart';
import 'package:marvelapp/widgets/custom_neopop_btn.dart';
import 'package:marvelapp/widgets/custom_superhero_timeline.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SuperHeroDescriptionScreen extends StatelessWidget {
  final String characterName;
  final String characterCoverUrl;
  final String indicatorPhotoUrl;
  final String characterPara1;
  final String characterPara2;
  final String characterQuotes;
  final String characterModal;

  const SuperHeroDescriptionScreen({
    super.key,
    required this.characterName,
    required this.characterCoverUrl,
    required this.indicatorPhotoUrl,
    required this.characterPara1,
    required this.characterPara2,
    required this.characterQuotes,
    required this.characterModal,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Consumer2<SuperHeroCharacterDBProvider, InternetCheckerProvider>(
          builder: (
            context,
            superHeroCharacterDBProvider,
            internetCheckerProvider,
            child,
          ) {
            if (!internetCheckerProvider.isNetworkConnected) {
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Lottie.asset(
                    'assets/images/animation/robot-animation.json',
                    height: size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Connection error",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: size.width * 0.050,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      "It seems you aren't connected to the internet. Try checking your connection or switching between Wi-Fi and cellular data.",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size.width * 0.036,
                        fontWeight: FontWeight.w500,
                        color: AppColors.subTitleColor,
                      ),
                    ),
                  ),
                ],
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Marvel character image
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: characterCoverUrl,
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
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            top: 16,
                          ),
                          child: SvgPicture.asset(
                            "assets/images/svg/back-icon.svg",
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.05,
                            fit: BoxFit.cover,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 0,
                      bottom: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Character name
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          lineXY: 0,
                          isFirst: true,
                          indicatorStyle: IndicatorStyle(
                            width: 34,
                            height: 34,
                            indicator: CachedNetworkImage(
                              imageUrl: indicatorPhotoUrl,
                              placeholder: (context, url) {
                                return LoadingAnimationWidget.dotsTriangle(
                                  color: AppColors.secondaryColor,
                                  size: 16,
                                );
                              },
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.timeLineBgColor,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                            padding: const EdgeInsets.all(4),
                          ),
                          beforeLineStyle: LineStyle(
                            color: AppColors.timeLineBgColor,
                            thickness: 2,
                          ),
                          endChild: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              characterName,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondaryColor,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.064,
                              ),
                            ),
                          ),
                        ),

                        /// para 1
                        CustomSuperHeroTimelineTile(
                          imageUrl: indicatorPhotoUrl,
                          text: characterPara1,
                        ),

                        /// para 2
                        CustomSuperHeroTimelineTile(
                          imageUrl: indicatorPhotoUrl,
                          text: characterPara2,
                        ),

                        TimelineTile(
                          alignment: TimelineAlign.start,
                          lineXY: 0,
                          isLast: true,
                          indicatorStyle: IndicatorStyle(
                            width: 34,
                            height: 34,
                            indicator: CachedNetworkImage(
                              imageUrl: indicatorPhotoUrl,
                              placeholder: (context, url) {
                                return LoadingAnimationWidget.dotsTriangle(
                                  color: AppColors.secondaryColor,
                                  size: 16,
                                );
                              },
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.timeLineBgColor,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                            padding: const EdgeInsets.all(4),
                          ),
                          beforeLineStyle: LineStyle(
                            color: AppColors.timeLineBgColor,
                            thickness: 2,
                          ),
                          endChild: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SingleChildScrollView(
                              clipBehavior: Clip.antiAlias,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Video 1 (No left margin)
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const VideoPlayerScreen();
                                      }));
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: size.height * 0.1,
                                          width: size.width * 0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://i.pinimg.com/564x/93/11/ca/9311caae8ca0783b6173889e8da61cab.jpg",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: LoadingAnimationWidget
                                                    .dotsTriangle(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  size: 26,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.play_circle_fill,
                                              size: 32, // Adjust size as needed
                                              color: AppColors
                                                  .secondaryColor, // Adjust color as needed
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Video 2 (With left and right margin)
                                  Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 16,
                                        ),
                                        height: size.height * 0.1,
                                        width: size.width * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://i.pinimg.com/564x/93/11/ca/9311caae8ca0783b6173889e8da61cab.jpg",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: LoadingAnimationWidget
                                                  .dotsTriangle(
                                                color: AppColors.secondaryColor,
                                                size: 26,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                              Icons.error,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            size: 32, // Adjust size as needed
                                            color: AppColors
                                                .secondaryColor, // Adjust color as needed
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Video 3 (With left and right margin)
                                  Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 16,
                                        ),
                                        height: size.height * 0.1,
                                        width: size.width * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://i.pinimg.com/564x/93/11/ca/9311caae8ca0783b6173889e8da61cab.jpg",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: LoadingAnimationWidget
                                                  .dotsTriangle(
                                                color: AppColors.secondaryColor,
                                                size: 26,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                              Icons.error,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            size: 32, // Adjust size as needed
                                            color: AppColors
                                                .secondaryColor, // Adjust color as needed
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Video 4 (No right margin)
                                  Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 16,
                                        ),
                                        height: size.height * 0.1,
                                        width: size.width * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://i.pinimg.com/564x/93/11/ca/9311caae8ca0783b6173889e8da61cab.jpg",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: LoadingAnimationWidget
                                                  .dotsTriangle(
                                                color: AppColors.secondaryColor,
                                                size: 26,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                              Icons.error,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Using Positioned to Center the Icon
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            size: 32, // Adjust size as needed
                                            color: AppColors
                                                .secondaryColor, // Adjust color as needed
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),

                        CustomNeoPopButton(
                          buttonColor: AppColors.secondaryColor,
                          svgColor: AppColors.primaryColor,
                          svgAssetPath: "assets/images/svg/super-hero-icon.svg",
                          buttonText: "View 3d modal",
                          onTapUp: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CharacterModelScreen(
                                characterModal: characterModal,
                                characterName: characterName,
                                characterQuotes: characterQuotes,
                              );
                            }));
                          },
                        ),
                      ],
                    ),
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

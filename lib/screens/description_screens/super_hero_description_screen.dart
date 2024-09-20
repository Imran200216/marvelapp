import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/db_provider/super_hero_character_db_provider.dart';
import 'package:marvelapp/screens/character_model_screen.dart';
import 'package:marvelapp/screens/video_player_screen.dart';
import 'package:marvelapp/widgets/custom_neopop_btn.dart';
import 'package:marvelapp/widgets/custom_superhero_timeline.dart';
import 'package:marvelapp/widgets/internet_checker.dart';
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
  final List<dynamic> characterVideos;

  const SuperHeroDescriptionScreen({
    super.key,
    required this.characterName,
    required this.characterCoverUrl,
    required this.indicatorPhotoUrl,
    required this.characterPara1,
    required this.characterPara2,
    required this.characterQuotes,
    required this.characterModal,
    required this.characterVideos,
  });

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
          body:
              Consumer2<SuperHeroCharacterDBProvider, InternetCheckerProvider>(
            builder: (
              context,
              superHeroCharacterDBProvider,
              internetCheckerProvider,
              child,
            ) {
              return LiquidPullToRefresh(
                showChildOpacityTransition: true,
                onRefresh: () async {
                  // Trigger refresh by calling the provider method to reload data
                  await superHeroCharacterDBProvider.fetchSuperHeroes();
                },
                color: AppColors.timeLineBgColor,
                // The color of the refresh indicator
                backgroundColor: AppColors.pullToRefreshBgColor,
                child: (!internetCheckerProvider.isNetworkConnected)
                    ? const InternetCheckerContent()
                    : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Marvel character image
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: characterCoverUrl,
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
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
                              child: AnimationLimiter(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        AnimationConfiguration.toStaggeredList(
                                      duration:
                                          const Duration(milliseconds: 600),
                                      childAnimationBuilder: (widget) {
                                        return SlideAnimation(
                                          horizontalOffset: 50.0,
                                          child: FadeInAnimation(child: widget),
                                        );
                                      },
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
                                                return LoadingAnimationWidget
                                                    .dotsTriangle(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  size: 16,
                                                );
                                              },
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  width: 34,
                                                  height: 34,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors
                                                        .timeLineBgColor,
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
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.064,
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

                                        /// videos
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
                                                return LoadingAnimationWidget
                                                    .dotsTriangle(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  size: 16,
                                                );
                                              },
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  width: 34,
                                                  height: 34,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors
                                                        .timeLineBgColor,
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
                                            child: SizedBox(
                                              height: 102,
                                              child: ListView.builder(
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    characterVideos.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return VideoPlayerScreen(
                                                                videoUrl:
                                                                    characterVideos[
                                                                        index],
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height:
                                                                size.height *
                                                                    0.1,
                                                            width: size.width *
                                                                0.3,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    "https://i.pinimg.com/564x/93/11/ca/9311caae8ca0783b6173889e8da61cab.jpg",
                                                                fit: BoxFit
                                                                    .cover,
                                                                placeholder:
                                                                    (context,
                                                                            url) =>
                                                                        Center(
                                                                  child: LoadingAnimationWidget
                                                                      .dotsTriangle(
                                                                    color: AppColors
                                                                        .secondaryColor,
                                                                    size: 26,
                                                                  ),
                                                                ),
                                                                errorWidget:
                                                                    (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(
                                                                  Icons.error,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned.fill(
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Icon(
                                                                Icons
                                                                    .play_circle_fill,
                                                                size: 32,
                                                                // Adjust size as needed
                                                                color: AppColors
                                                                    .secondaryColor, // Adjust color as needed
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),

                                        CustomNeoPopButton(
                                          buttonColor: AppColors.secondaryColor,
                                          svgColor: AppColors.primaryColor,
                                          svgAssetPath:
                                              "assets/images/svg/super-hero-icon.svg",
                                          buttonText: "View 3d modal",
                                          onTapUp: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return CharacterModelScreen(
                                                characterModal: characterModal,
                                                characterName: characterName,
                                                characterQuotes:
                                                    characterQuotes,
                                              );
                                            }));
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

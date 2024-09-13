import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SuperHeroDescriptionScreen extends StatelessWidget {
  final String characterName;
  final String characterCoverUrl;
  final String indicatorPhotoUrl;
  final String characterPara1;
  final String characterPara2;

  const SuperHeroDescriptionScreen({
    super.key,
    required this.characterName,
    required this.characterCoverUrl,
    required this.indicatorPhotoUrl,
    required this.characterPara1,
    required this.characterPara2,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
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
                        indicator: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(indicatorPhotoUrl),
                          child: CachedNetworkImage(
                            imageUrl: indicatorPhotoUrl,
                            placeholder: (context, url) => Center(
                              child: LoadingAnimationWidget.dotsTriangle(
                                color: AppColors.secondaryColor,
                                size: 34,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: AppColors.secondaryColor,
                            ),
                            fit: BoxFit.cover,
                          ),
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
                            fontSize: MediaQuery.of(context).size.width * 0.064,
                          ),
                        ),
                      ),
                    ),

                    /// Timeline Tile for the first paragraph
                    TimelineTile(
                      alignment: TimelineAlign.start,
                      lineXY: 0,
                      indicatorStyle: IndicatorStyle(
                        width: 34,
                        height: 34,
                        indicator: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(indicatorPhotoUrl),
                          child: CachedNetworkImage(
                            imageUrl: indicatorPhotoUrl,
                            placeholder: (context, url) => Center(
                              child: LoadingAnimationWidget.dotsTriangle(
                                color: AppColors.secondaryColor,
                                size: 34,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: AppColors.secondaryColor,
                            ),
                            fit: BoxFit.cover,
                          ),
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
                          characterPara1,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.subTitleColor,
                            fontFamily: "Poppins",
                            fontSize: MediaQuery.of(context).size.width * 0.038,
                          ),
                        ),
                      ),
                    ),

                    /// Timeline Tile for the second paragraph
                    TimelineTile(
                      alignment: TimelineAlign.start,
                      lineXY: 0,
                      isLast: true,
                      indicatorStyle: IndicatorStyle(
                        width: 34,
                        height: 34,
                        indicator: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(indicatorPhotoUrl),
                          child: CachedNetworkImage(
                            imageUrl: indicatorPhotoUrl,
                            placeholder: (context, url) => Center(
                              child: LoadingAnimationWidget.dotsTriangle(
                                color: AppColors.secondaryColor,
                                size: 34,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: AppColors.secondaryColor,
                            ),
                            fit: BoxFit.cover,
                          ),
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
                          characterPara2,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: AppColors.subTitleColor,
                            fontSize: MediaQuery.of(context).size.width * 0.038,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

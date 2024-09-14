import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/modals/mcu_modal.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MovieDescriptionScreen extends StatelessWidget {
  final McuModal movie;

  const MovieDescriptionScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              top: 30,
              right: 20,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    "assets/images/svg/back-icon.svg",
                    height: size.height * 0.05,
                    width: size.width * 0.05,
                    fit: BoxFit.cover,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Text(
                  textAlign: TextAlign.start,
                  movie.title ?? 'No Title Available',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: size.width * 0.050,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  height: size.height * 0.6,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: movie.coverUrl ??
                          "https://i.pinimg.com/564x/93/11/ca/9311caae8ca0783b6173889e8da61cab.jpg",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: AppColors.secondaryColor,
                          size: 26,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TimelineTile(
                  alignment: TimelineAlign.start,
                  lineXY: 0,
                  isFirst: true,
                  indicatorStyle: IndicatorStyle(
                    width: 34,
                    height: 34,
                    indicator: CachedNetworkImage(
                      imageUrl:
                          "https://i.pinimg.com/564x/a2/d7/a6/a2d7a6ddce35f2bf9c53fe9fbd22971f.jpg",
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
                      movie.overview ?? 'Releasing soon',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryColor,
                        fontSize: size.width * 0.038,
                      ),
                    ),
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.start,
                  lineXY: 0,
                  indicatorStyle: IndicatorStyle(
                    width: 34,
                    height: 34,
                    indicator: CachedNetworkImage(
                      imageUrl:
                          "https://i.pinimg.com/564x/a2/d7/a6/a2d7a6ddce35f2bf9c53fe9fbd22971f.jpg",
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
                      'Release Date: ${movie.releaseDate ?? 'Releasing soon'}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.subTitleColor,
                        fontFamily: "Poppins",
                        fontSize: MediaQuery.of(context).size.width * 0.038,
                      ),
                    ),
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.start,
                  lineXY: 0,
                  indicatorStyle: IndicatorStyle(
                    width: 34,
                    height: 34,
                    indicator: CachedNetworkImage(
                      imageUrl:
                          "https://i.pinimg.com/564x/a2/d7/a6/a2d7a6ddce35f2bf9c53fe9fbd22971f.jpg",
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
                      'Box Office: ${movie.boxOffice ?? 'Unknown'}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.subTitleColor,
                        fontFamily: "Poppins",
                        fontSize: MediaQuery.of(context).size.width * 0.038,
                      ),
                    ),
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.start,
                  lineXY: 0,
                  indicatorStyle: IndicatorStyle(
                    width: 34,
                    height: 34,
                    indicator: CachedNetworkImage(
                      imageUrl:
                          "https://i.pinimg.com/564x/a2/d7/a6/a2d7a6ddce35f2bf9c53fe9fbd22971f.jpg",
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
                      'Duration: ${movie.duration?.toString() ?? 'Unknown'} minutes',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.subTitleColor,
                        fontFamily: "Poppins",
                        fontSize: MediaQuery.of(context).size.width * 0.038,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

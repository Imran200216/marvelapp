import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/modals/mcu_modal.dart';
import 'package:marvelapp/provider/app_required_providers/conversion_provider.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/app_required_providers/url_launcher_provider.dart';
import 'package:marvelapp/widgets/custom_movie_timeline.dart';

import 'package:marvelapp/widgets/custom_neopop_btn.dart';

import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

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
        body: Consumer3<ConversionProvider, InternetCheckerProvider,
            UrlLauncherProvider>(
          builder: (
            context,
            conversionProvider,
            internetCheckerProvider,
            urlLauncherProvider,
            child,
          ) {
            // Check if there is an internet connection
            if (!internetCheckerProvider.isNetworkConnected) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        "It seems you aren't connected to the internet. Try checking your connection or switching between Wi-Fi adn cellular data.",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: size.width * 0.036,
                          fontWeight: FontWeight.w500,
                          color: AppColors.subTitleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// image
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.6,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
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

                      /// back icon
                      Positioned(
                        top: 22,
                        left: 16,
                        child: InkWell(
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
                      ),

                      /// download trailer icon
                      Positioned(
                        top: 22,
                        right: 16,
                        child: InkWell(
                          onTap: () {
                            downloadFile(
                              "https://players.brightcove.net/5359769168001/BJemW31x6g_default/index.html?videoId=5786306590001",
                              context,
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/images/svg/download-container-icon.svg",
                            height: size.height * 0.05,
                            width: size.width * 0.05,
                            fit: BoxFit.cover,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),

                  /// movie title
                  TimelineTile(
                    isFirst: true,
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
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Movie name \n',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: AppColors.subTitleColor,
                                fontSize: size.width * 0.040,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: movie.title ?? "Releasing soon",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: AppColors.secondaryColor,
                                fontSize: size.width * 0.064,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// infinity saga
                  CustomMovieTimelineTile(
                    title: 'Saga',
                    subtitle: movie.saga ?? "Releasing soon",
                  ),

                  ///movie duration
                  CustomMovieTimelineTile(
                    title: 'Duration',
                    subtitle: conversionProvider.formatDuration(movie.duration),
                  ),

                  /// release date
                  CustomMovieTimelineTile(
                    title: 'Release Date',
                    subtitle: conversionProvider.formatDate(movie.releaseDate),
                  ),

                  /// directed by
                  CustomMovieTimelineTile(
                    title: 'Directed by',
                    subtitle: movie.directedBy ?? "Releasing soon",
                  ),

                  /// overview of movie
                  CustomMovieTimelineTile(
                    title: 'Overview',
                    subtitle: movie.overview ?? "Releasing soon",
                  ),

                  /// box office
                  CustomMovieTimelineTile(
                    isLast: true,
                    title: 'Box office collection',
                    subtitle:
                        conversionProvider.formatBoxOffice(movie.boxOffice),
                  ),

                  /// watch trailer btn
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                      bottom: 30,
                      right: 20,
                    ),
                    child: CustomNeoPopButton(
                      buttonColor: AppColors.secondaryColor,
                      svgColor: AppColors.primaryColor,
                      svgAssetPath: "assets/images/svg/play-icon.svg",
                      buttonText: "Play trailer",
                      onTapUp: () async {
                        final String? trailerUrl = movie.trailerUrl;

                        /// Check if the trailer URL is valid
                        urlLauncherProvider.launchUrlInBrowser(
                            Uri.parse(trailerUrl ?? "No Url Found"), context);
                      },
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

  /// download functionality
  Future<void> downloadFile(String url, BuildContext context) async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/myFile.mp3";

      // Start the download
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // Optionally, you can show a progress indicator here
            print('${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );

      // Show a success toast when the download is completed
      ToastHelper.showSuccessToast(
        context: context,
        message: "Download completed successfully!",
      );
      print("Download completed");
    } catch (e) {
      // Show an error toast if the download fails
      ToastHelper.showErrorToast(
        context: context,
        message: "Failed to download file. Please try again.",
      );
      print("Error: $e");
    }
  }
}

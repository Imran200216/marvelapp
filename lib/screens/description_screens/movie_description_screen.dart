import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/modals/mcu_modal.dart';

import 'package:marvelapp/widgets/custom_neopop_btn.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:path_provider/path_provider.dart';

import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

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

              /// overview of movie
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

              /// release date
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

              /// box office
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

              /// duration
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

                    // Check if the trailer URL is valid
                    _launchUrl(
                        Uri.parse(trailerUrl ?? "No Url found"), context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// launcher url functionality
  Future<void> _launchUrl(Uri url, BuildContext context) async {
    if (!await launchUrl(url)) {
      // Show an error toast if the URL cannot be launched
      ToastHelper.showErrorToast(
        context: context,
        message: "Cannot load the trailer. Please try again.",
      );
    }
  }

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

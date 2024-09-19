import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:lottie/lottie.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/app_required_providers/video_player_provider.dart';
import 'package:provider/provider.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return ChangeNotifierProvider(
      create: (_) => VideoPlayerProvider(videoUrl),
      child: Consumer2<VideoPlayerProvider, InternetCheckerProvider>(
        builder: (
          context,
          videoPlayerProvider,
          internetCheckerProvider,
          child,
        ) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
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
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Marvel Fan Videos",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize:
                            isPortrait ? size.width * 0.05 : size.height * 0.05,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    // Handle network check
                    !internetCheckerProvider.isNetworkConnected
                        ? Center(
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    "It seems you aren't connected to the internet. Try checking your connection or switching between Wi-Fi and cellular data.",
                                    textAlign: TextAlign.center,
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
                          )
                        : videoPlayerProvider.isInitialized &&
                                videoPlayerProvider.chewieController != null
                            ? AspectRatio(
                                aspectRatio: isPortrait ? 16 / 9 : 16 / 10,
                                child: Chewie(
                                  controller:
                                      videoPlayerProvider.chewieController!,
                                ),
                              )
                            : Center(
                                child: Lottie.asset(
                                  "assets/images/animation/video-loading-animation.json",
                                  height: size.height * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

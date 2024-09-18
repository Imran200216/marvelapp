import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/app_required_providers/video_player_provider.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return ChangeNotifierProvider(
      /// initializing the video player provider
      create: (context) => VideoPlayerProvider(videoUrl),
      child: Consumer2<VideoPlayerProvider, InternetCheckerProvider>(
        builder: (
          context,
          videoPlayerProvider,
          internetCheckerProvider,
          child,
        ) {
          return DoubleTapToExit(
            snackBar: SnackBar(
              backgroundColor: AppColors.timeLineBgColor,
              content: Text(
                "Tap again to exit!",
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
                body: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
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
                              height: isPortrait
                                  ? size.height * 0.05
                                  : size.width * 0.05,
                              width: isPortrait
                                  ? size.width * 0.05
                                  : size.height * 0.05,
                              fit: BoxFit.cover,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            "Marvel Fan Videos",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: isPortrait
                                  ? size.width * 0.050
                                  : size.height * 0.050,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            height: isPortrait
                                ? size.height * 0.05 // Reduced space
                                : size.width *
                                    0.05, // Adjust space for landscape as well
                          ),
                          !internetCheckerProvider.isNetworkConnected
                              ? Column(
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
                                )
                              : Center(
                                  child: AspectRatio(
                                    aspectRatio: isPortrait ? 16 / 9 : 16 / 10,
                                    child: Chewie(
                                      controller:
                                          videoPlayerProvider.chewieController,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

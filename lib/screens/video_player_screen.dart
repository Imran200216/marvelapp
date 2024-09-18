import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return ChangeNotifierProvider(
      create: (_) => VideoPlayerProvider(videoUrl),
      child: Consumer2<VideoPlayerProvider, InternetCheckerProvider>(
        builder: (context, videoPlayerProvider, internetCheckerProvider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primaryColor,
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    "assets/images/svg/back-icon.svg",
                    color: AppColors.secondaryColor,
                    height: size.height * 0.03,
                    width: size.width * 0.03,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  "Marvel Fan Videos",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: isPortrait ? size.width * 0.05 : size.height * 0.05,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: !internetCheckerProvider.isNetworkConnected
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
                        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    : FutureBuilder(
                  future: videoPlayerProvider.chewieController.videoPlayerController.value.isInitialized
                      ? Future.value(true)
                      : videoPlayerProvider.chewieController.videoPlayerController.initialize(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: AppColors.secondaryColor,
                          size: size.height * 0.08,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error loading video",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: size.width * 0.045,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      );
                    } else {
                      return AspectRatio(
                        aspectRatio: isPortrait ? 16 / 9 : 16 / 10,
                        child: Chewie(
                          controller: videoPlayerProvider.chewieController,
                        ),
                      );
                    }
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

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider with ChangeNotifier {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  VideoPlayerProvider(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.secondaryColor,
        handleColor: AppColors.secondaryColor,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white24,
      ),
      placeholder: Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: AppColors.secondaryColor,
          size: 20,
        ),
      ),
    );
  }

  ChewieController get chewieController => _chewieController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
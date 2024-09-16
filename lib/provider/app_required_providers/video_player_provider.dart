import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider with ChangeNotifier {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  VideoPlayerProvider() {
    _videoPlayerController = VideoPlayerController.network(
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    );

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
      placeholder: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  ChewieController get chewieController => _chewieController;
}

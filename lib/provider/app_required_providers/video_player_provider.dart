import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider with ChangeNotifier {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;


  late CachedVideoPlayerController _videoPlayerController;

  VideoPlayerProvider(String videoUrl) {
    _videoPlayerController = CachedVideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        notifyListeners();
      });
    _videoPlayerController.setLooping(true);
  }

  CachedVideoPlayerController get videoPlayerController => _videoPlayerController;

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
      placeholder: const Center(
        child: CircularProgressIndicator(),
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

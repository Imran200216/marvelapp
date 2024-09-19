import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider with ChangeNotifier {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController; // Make this nullable
  bool _isInitialized = false; // Track initialization state

  // Custom cache manager instance to control caching behavior
  final _videoCacheManager = CacheManager(
    Config(
      'videoCacheKey',
      stalePeriod: const Duration(days: 7), // Cache duration
      maxNrOfCacheObjects: 50,
    ),
  );

  VideoPlayerProvider(String videoUrl) {
    _initializeVideoPlayer(videoUrl);
  }

  Future<void> _initializeVideoPlayer(String videoUrl) async {
    // Check if video is already cached
    final fileInfo = await _videoCacheManager.getFileFromCache(videoUrl);

    if (fileInfo != null && fileInfo.file.existsSync()) {
      // If cached, play the video from cache
      _videoPlayerController = VideoPlayerController.file(fileInfo.file);
    } else {
      // If not cached, download and cache the video
      final file = await _videoCacheManager.getSingleFile(videoUrl);
      _videoPlayerController = VideoPlayerController.file(file);
    }

    await _videoPlayerController.initialize();

    // Initialize the ChewieController with video player
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
    _isInitialized = true; // Set initialization flag to true
    notifyListeners();
  }

  bool get isInitialized => _isInitialized; // Expose the initialization state

  ChewieController? get chewieController => _chewieController; // Nullable getter

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}

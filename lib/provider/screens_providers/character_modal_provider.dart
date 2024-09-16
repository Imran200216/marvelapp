import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CharacterModelProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isScrolling = false;
  bool _autoRotate = true;
  bool _isAudioOn = true; // New field to track audio state

  // Getter for auto-rotate
  bool get autoRotate => _autoRotate;

  // Getter for isScrolling
  bool get isScrolling => _isScrolling;

  // Getter for isAudioOn
  bool get isAudioOn => _isAudioOn;

  // Scroll controller for detecting scroll changes
  final ScrollController scrollController = ScrollController();

  CharacterModelProvider() {
    // Attach scroll listener
    scrollController.addListener(_onScroll);
  }

  // Function to play audio
  Future<void> _playAudio() async {
    if (!_isPlaying && _isAudioOn) {
      await _audioPlayer.play(AssetSource('audio/demo.mp3'));
      _isPlaying = true;
      notifyListeners();
    }
  }

  // Function to stop audio
  Future<void> _stopAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      _isPlaying = false;
      notifyListeners();
    }
  }

  // Function to handle scroll changes
  void _onScroll() {
    if (scrollController.position.isScrollingNotifier.value) {
      if (!_isScrolling) {
        _isScrolling = true;
        _autoRotate = false;
        notifyListeners();
      }
    } else if (_isScrolling) {
      _isScrolling = false;
      _autoRotate = true;
      notifyListeners();
    }
  }

  // Function to handle visibility
  void handleVisibilityChange(double visibleFraction) {
    if (visibleFraction > 0.3) {
      _playAudio();
    } else {
      _stopAudio();
    }
  }

  // Function to toggle audio state
  void toggleAudio() {
    _isAudioOn = !_isAudioOn;
    if (!_isAudioOn) {
      _stopAudio(); // Stop audio if it's turned off
    }
    print("Audio is ${_isAudioOn ? "On" : "Off"}"); // Debug print
    notifyListeners();
  }

  // Function to set audio playback
  void setAudioPlayback(bool shouldPlay) {
    if (shouldPlay && _isAudioOn) {
      _playAudio();
      notifyListeners();
    } else {
      _stopAudio();
      notifyListeners();
    }
  }
}

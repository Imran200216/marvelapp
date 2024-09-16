import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/provider/screens_providers/character_modal_provider.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class CharacterModelScreen extends StatefulWidget {
  final String characterName;

  final String characterQuotes;

  final String characterModal;

  const CharacterModelScreen({
    super.key,
    required this.characterName,
    required this.characterQuotes,
    required this.characterModal,
  });

  @override
  _CharacterModelScreenState createState() => _CharacterModelScreenState();
}

class _CharacterModelScreenState extends State<CharacterModelScreen>
    with WidgetsBindingObserver {
  late CharacterModelProvider characterModelProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save a reference to the provider here
    characterModelProvider =
        Provider.of<CharacterModelProvider>(context, listen: false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      characterModelProvider.setAudioPlayback(false);
    } else if (state == AppLifecycleState.resumed) {
      characterModelProvider.setAudioPlayback(true);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _scrollToTop() {
    // Animate scroll to the top
    characterModelProvider.scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF010100),
        body: SingleChildScrollView(
          controller: characterModelProvider.scrollController,
          child: Container(
            margin: EdgeInsets.only(
              left: size.width * 0.05, // Adjust margins as needed
              top: size.height * 0.03,
              right: size.width * 0.05,
              bottom: size.height * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02, // Reduced space
                ),

                /// character name
                Text(
                  widget.characterName,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: size.width * 0.060,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor,
                  ),
                ),

                SizedBox(
                  height: size.height * 0.01, // Further reduced space
                ),

                /// Character quotes
                SizedBox(
                  width: size.width * 0.9, // Adjust width as needed
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor,
                      fontFamily: 'Poppins',
                    ),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      repeatForever: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          widget.characterQuotes,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: size.height * 0.02, // Reduced space
                ),

                /// 3D model with visibility detector
                VisibilityDetector(
                  key: const Key('3d-model-viewer'),
                  onVisibilityChanged: (VisibilityInfo info) {
                    // Ensure the widget is mounted before accessing the provider
                    if (mounted) {
                      characterModelProvider
                          .handleVisibilityChange(info.visibleFraction);
                    }
                  },
                  child: SizedBox(
                    height: size.height * 0.6, // Adjust height as needed
                    width: size.width,
                    child: Consumer<CharacterModelProvider>(
                      builder: (context, provider, child) {
                        /// 3d modal
                        return ModelViewer(
                          autoPlay: false,
                          backgroundColor: AppColors.primaryColor,
                          src: widget.characterModal,
                          autoRotate: provider.autoRotate,
                          disableZoom: provider.isScrolling,
                          cameraControls: !provider.isScrolling,
                        );
                      },
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: _scrollToTop, // Call the scroll method
                      child: Container(
                        height: size.height * 0.07, // Container height
                        width: size.width * 0.09, // Container width
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.035),
                          // Rounded corners
                          color: AppColors.secondaryColor,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/images/svg/arrow-up-icon.svg",
                            color: AppColors.primaryColor,
                            height: size.height * 0.03,
                            width: size.width * 0.03,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/db_provider/super_hero_character_db_provider.dart';
import 'package:marvelapp/provider/screens_providers/character_modal_provider.dart';
import 'package:marvelapp/widgets/internet_checker.dart';
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
  late SuperHeroCharacterDBProvider superHeroProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save a reference to the correct providers here
    characterModelProvider =
        Provider.of<CharacterModelProvider>(context, listen: false);
    superHeroProvider =
        Provider.of<SuperHeroCharacterDBProvider>(context, listen: false);

    // Fetch the 3D model when the screen is displayed
    superHeroProvider.fetchCharacterModel(widget.characterName);
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

    return DoubleTapToExit(
      snackBar: SnackBar(
        backgroundColor: AppColors.timeLineBgColor,
        content: Text(
          "Tag again to exit!",
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
          backgroundColor: const Color(0xFF010100),
          body: Consumer<InternetCheckerProvider>(
            builder: (
              context,
              internetCheckerProvider,
              child,
            ) {
              return LiquidPullToRefresh(
                showChildOpacityTransition: true,
                onRefresh: () async {
                  // Fetch the 3D model when the screen is displayed
                  await superHeroProvider
                      .fetchCharacterModel(widget.characterName);
                },
                color: AppColors.timeLineBgColor,
                // The color of the refresh indicator
                backgroundColor: AppColors.pullToRefreshBgColor,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                          height: size.height * 0.02,
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

                        if (!internetCheckerProvider.isNetworkConnected)
                          const InternetCheckerContent()
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.01,
                              ),

                              /// Character quotes
                              SizedBox(
                                width: size.width * 0.9,
                                // Adjust width as needed
                                child: DefaultTextStyle(
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: size.width * 0.07,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryColor,
                                    fontFamily: 'Poppins',
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/svg/quotes-start-icon.svg",
                                        height: size.height * 0.04,
                                        color: AppColors.secondaryColor,
                                        fit: BoxFit.cover,
                                      ),
                                      AnimatedTextKit(
                                        isRepeatingAnimation: false,
                                        repeatForever: true,
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            widget.characterQuotes,
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset(
                                        "assets/images/svg/quotes-end-icon.svg",
                                        height: size.height * 0.04,
                                        color: AppColors.secondaryColor,
                                        fit: BoxFit.cover,
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
                                        .handleVisibilityChange(
                                            info.visibleFraction);
                                  }
                                },
                                child: SizedBox(
                                  height: size.height * 0.6,
                                  // Adjust height as needed
                                  width: size.width,
                                  child: Consumer<SuperHeroCharacterDBProvider>(
                                    builder: (context, provider, child) {
                                      if (provider.isModelLoading) {
                                        // Show Lottie animation while loading
                                        return Center(
                                          child: LoadingAnimationWidget
                                              .threeArchedCircle(
                                            color: AppColors.secondaryColor,
                                            size: 32,
                                          ),
                                        );
                                      }

                                      if (provider.characterModelUrl == null) {
                                        return Center(
                                          child: Column(
                                            children: [
                                              Lottie.asset(
                                                'assets/images/animation/empty-animation.json',
                                                height: size.height * 0.3,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Text(
                                                'Admin will be update soon!',
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      AppColors.secondaryColor,
                                                  fontSize: size.width * 0.04,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }

                                      /// 3D model
                                      return ModelViewer(
                                        ar: true,
                                        alt: "No modal found!",
                                        loading: Loading.eager,
                                        autoPlay: false,
                                        backgroundColor: AppColors.primaryColor,
                                        src: widget.characterModal,
                                        autoRotate:
                                            characterModelProvider.autoRotate,
                                        disableZoom:
                                            characterModelProvider.isScrolling,
                                        cameraControls:
                                            !characterModelProvider.isScrolling,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: _scrollToTop,
                                    // Call the scroll method
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        right: 20,
                                      ),
                                      height: size.height * 0.07,
                                      // Container height
                                      width: size.width * 0.09,
                                      // Container width
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.035),
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
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

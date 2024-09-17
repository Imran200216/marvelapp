import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:marvelapp/modals/modal_cache_manager.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/db_provider/super_hero_character_db_provider.dart';
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
  late SuperHeroCharacterDBProvider superHeroProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    characterModelProvider =
        Provider.of<CharacterModelProvider>(context, listen: false);
    superHeroProvider =
        Provider.of<SuperHeroCharacterDBProvider>(context, listen: false);

    // Fetch the 3D model URL and cache it
    superHeroProvider.fetchCharacterModel(widget.characterName).then((_) {
      // Caching the model URL
      final modelUrl = superHeroProvider.characterModelUrl;
      if (modelUrl != null) {
        ModelCacheManager.instance.downloadFile(modelUrl);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
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
    characterModelProvider.scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<String?> _getCachedModelUrl() async {
    final file = await ModelCacheManager.instance
        .getFileFromCache(widget.characterModal);
    return file?.file.path;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF010100),
        body: Consumer<InternetCheckerProvider>(
          builder: (context, internetCheckerProvider, child) {
            return LiquidPullToRefresh(
              showChildOpacityTransition: true,
              onRefresh: () async {
                await superHeroProvider
                    .fetchCharacterModel(widget.characterName);
                final modelUrl = superHeroProvider.characterModelUrl;
                if (modelUrl != null) {
                  ModelCacheManager.instance.downloadFile(modelUrl);
                }
              },
              color: AppColors.timeLineBgColor,
              backgroundColor: AppColors.pullToRefreshBgColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: characterModelProvider.scrollController,
                child: Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.05,
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 6),
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
                              margin:
                                  const EdgeInsets.only(left: 12, right: 12),
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
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: size.width * 0.9,
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
                                        widget.characterQuotes),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            VisibilityDetector(
                              key: const Key('3d-model-viewer'),
                              onVisibilityChanged: (VisibilityInfo info) {
                                if (mounted) {
                                  characterModelProvider.handleVisibilityChange(
                                      info.visibleFraction);
                                }
                              },
                              child: SizedBox(
                                height: size.height * 0.6,
                                width: size.width,
                                child: Consumer<SuperHeroCharacterDBProvider>(
                                  builder: (context, provider, child) {
                                    if (provider.isModelLoading) {
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
                                              'Admin will be updated soon!',
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.secondaryColor,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    return FutureBuilder<String?>(
                                      future: _getCachedModelUrl(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .threeArchedCircle(
                                              color: AppColors.secondaryColor,
                                              size: 32,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: Text(
                                              'Error loading model',
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.secondaryColor,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          );
                                        } else {
                                          final modelUrl = snapshot.data;

                                          return ModelViewer(
                                            src: modelUrl ?? '',
                                            alt:
                                                'A 3D model of ${widget.characterName}',
                                            autoRotate: true,
                                            cameraControls: true,
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
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
    );
  }
}

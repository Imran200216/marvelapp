import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/db_provider/super_hero_character_db_provider.dart';
import 'package:marvelapp/screens/description_screens/super_hero_description_screen.dart';
import 'package:marvelapp/widgets/internet_checker.dart';
import 'package:provider/provider.dart';

class SuperHeroScreen extends StatelessWidget {
  const SuperHeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Consumer2<InternetCheckerProvider, SuperHeroCharacterDBProvider>(
          builder: (
            context,
            internetCheckerProvider,
            superHeroCharacterDBProvider,
            child,
          ) {
            return LiquidPullToRefresh(
              showChildOpacityTransition: true,
              onRefresh: () async {
                // Trigger refresh by calling the provider method to reload data
                await superHeroCharacterDBProvider.fetchSuperHeroes();
              },
              color: AppColors.timeLineBgColor,
              // The color of the refresh indicator
              backgroundColor: AppColors.pullToRefreshBgColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            "Marvel Super Hero\nCharacters",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SvgPicture.asset(
                            "assets/images/svg/super-hero-icon.svg",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            color: AppColors.secondaryColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      if (!internetCheckerProvider.isNetworkConnected)
                        const InternetCheckerContent()
                      else if (superHeroCharacterDBProvider.superHeroes.isEmpty)
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: size.height * 0.02),
                              Lottie.asset(
                                "assets/images/animation/super-hero-animation.json",
                                height: size.height * 0.4,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        )
                      else
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.56,
                          ),
                          itemCount:
                              superHeroCharacterDBProvider.superHeroes.length,
                          itemBuilder: (context, index) {
                            final character =
                                superHeroCharacterDBProvider.superHeroes[index];
                            final imageUrl =
                                character["characterCardPhotoUrl"] ?? '';

                            return OpenContainer(
                              transitionType: ContainerTransitionType.fade,
                              // Smooth transition
                              transitionDuration:
                                  const Duration(milliseconds: 800),
                              // Adjust transition speed
                              openBuilder: (context, _) =>
                                  SuperHeroDescriptionScreen(
                                characterQuotes: character['characterQuotes'],
                                characterModal: character['character3dModal'],
                                characterName: character['characterName'],
                                characterCoverUrl:
                                    character['characterCoverUrl'],
                                indicatorPhotoUrl:
                                    character['indicatorPhotoUrl'],
                                characterPara1: character['characterPara1'],
                                characterPara2: character['characterPara2'],
                                characterVideos: character['videos'],
                              ),
                              closedElevation: 0,
                              closedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              closedColor: Colors.transparent,
                              // Set to transparent for smoother effect
                              openColor: Colors.transparent,
                              // Set same as closed for consistency
                              closedBuilder: (context, openContainer) {
                                return InkWell(
                                  onTap: openContainer,
                                  // Triggers the open animation
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl.isNotEmpty
                                          ? imageUrl
                                          : 'https://i.pinimg.com/564x/2d/d1/2f/2dd12f14def5c18840f10599cfe9e54a.jpg',
                                      placeholder: (context, url) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/images/jpg/super-hero-placeholder.jpg",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: Icon(
                                          Icons.error,
                                          color: AppColors.secondaryColor,
                                          size: 50,
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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

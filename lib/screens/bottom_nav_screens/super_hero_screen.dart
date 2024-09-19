import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:lottie/lottie.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/db_provider/super_hero_character_db_provider.dart';
import 'package:marvelapp/screens/description_screens/super_hero_description_screen.dart';

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
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: size.width * 0.052,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColor,
                            ),
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
                        Column(
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
                            Container(
                              margin: const EdgeInsets.only(
                                left: 12,
                                right: 12,
                              ),
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
                      else if (superHeroCharacterDBProvider.superHeroes.isEmpty)
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: size.height * 0.02),
                              Lottie.asset(
                                "assets/images/animation/super-hero-animation.json",
                                height: size.height * 0.3,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "Fetching Marvel Hero's",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryColor,
                                  fontSize: size.width * 0.038,
                                  fontFamily: "Poppins",
                                ),
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

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SuperHeroDescriptionScreen(
                                      characterQuotes:
                                          character['characterQuotes'],
                                      characterModal:
                                          character['character3dModal'],
                                      characterName: character['characterName'],
                                      characterCoverUrl:
                                          character['characterCoverUrl'],
                                      indicatorPhotoUrl:
                                          character['indicatorPhotoUrl'],
                                      characterPara1:
                                          character['characterPara1'],
                                      characterPara2:
                                          character['characterPara2'],
                                      characterVideos: character['videos'],
                                    );
                                  }),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl.isNotEmpty
                                        ? imageUrl
                                        : 'https://i.pinimg.com/564x/2d/d1/2f/2dd12f14def5c18840f10599cfe9e54a.jpg',
                                    // Fallback image
                                    placeholder: (context, url) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                              ),
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

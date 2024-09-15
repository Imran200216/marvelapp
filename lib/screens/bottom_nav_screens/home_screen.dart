import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/db_provider/marvel_movie_db_provider.dart';
import 'package:marvelapp/screens/description_screens/movie_description_screen.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Consumer2<MarvelMoviesProvider, InternetCheckerProvider>(
          builder: (
            context,
            marvelMoviesProvider,
            internetCheckerProvider,
            child,
          ) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 30,
                  bottom: 30,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Marvel movie list &\nCool facts",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size.width * 0.052,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryColor,
                      ),
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
                              "It seems you aren't connected to the internet. Try checking your connection or switching between Wi-Fi adn cellular data.",
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
                    else if (marvelMoviesProvider.isLoading)
                      Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: AppColors.secondaryColor,
                          size: 50,
                        ),
                      )
                    else if (marvelMoviesProvider.mcuMoviesList.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: marvelMoviesProvider.mcuMoviesList.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final movie =
                              marvelMoviesProvider.mcuMoviesList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDescriptionScreen(movie: movie),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: movie.coverUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: movie.coverUrl.toString(),
                                      fit: BoxFit.cover,
                                    )
                                  : SvgPicture.asset(
                                      "assets/images/svg/marvel-placeholder.svg",
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: 80,
                                    ),
                            ),
                          );
                        },
                      )
                    else
                      Center(
                        child: Text(
                          'No movies found',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

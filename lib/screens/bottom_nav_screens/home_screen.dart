import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/db_provider/marvel_movie_db_provider.dart';
import 'package:marvelapp/screens/description_screens/movie_description_screen.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:marvelapp/provider/internet_checker_provider.dart';

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
                        fontSize: size.width * 0.060,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    if (!internetCheckerProvider.isNetworkConnected)
                      Center(
                        child: Lottie.asset(
                          'assets/images/animation/network-error-animation.json',
                          height: size.height * 0.5,
                          width: size.width * 0.8,
                          fit: BoxFit.cover,
                        ),
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

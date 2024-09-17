import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';

class AboutAppDetailsScreen extends StatelessWidget {
  const AboutAppDetailsScreen({super.key});

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
          backgroundColor: AppColors.primaryColor,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 30,
                top: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    "About app",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: size.width * 0.050,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    height: size.height * 0.3,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://i.pinimg.com/564x/93/11/ca/9311caae8ca0783b6173889e8da61cab.jpg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                            color: AppColors.secondaryColor,
                            size: 26,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    '''
      The Marvel App is an ultimate destination for all Marvel fans, designed to deliver an immersive and engaging experience. This app offers a comprehensive platform where users can explore the rich universe of Marvel movies, superheroes, and their iconic powers.
      
      At its core, the app features a Marvel Movie List, allowing users to browse through a catalog of movies, both old and new. For each movie, you’ll find cool facts that enrich your viewing experience—whether it's behind-the-scenes trivia, Easter eggs, or little-known details about your favorite films. This section brings the magic of the Marvel Cinematic Universe (MCU) to life in a way that fans will love.
      
      Beyond movies, the app dives into Marvel’s legendary superheroes. In the Superhero List section, you’ll find detailed profiles of iconic characters like Spider-Man, Iron Man, Thor, and more. Each superhero's unique powers are described in depth, alongside their origin stories, famous battles, and affiliations. The app is designed to make it easy to learn about both classic and lesser-known heroes, with a strong focus on celebrating the vastness of the Marvel Universe.
      
      To elevate the experience further, the app incorporates videos that include trailers, superhero battles, and fan-favorite clips. These videos help fans relive their favorite moments and get hyped for upcoming releases.
      
      The Marvel App is a fan-centric space, designed to provide an awesome, interactive experience where fans can geek out, stay informed, and explore every corner of the Marvel Universe. Whether you're catching up on movie facts or discovering new superheroes, this app is an exciting journey for every Marvel lover.
                  
                  
                  
                  ''',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryColor,
                      fontSize: size.width * 0.038,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

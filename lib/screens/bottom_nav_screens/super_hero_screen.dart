import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/super_hero_character_db_provider.dart';
import 'package:marvelapp/screens/super_hero_description_screen.dart';
import 'package:provider/provider.dart';

class SuperHeroScreen extends StatelessWidget {
  const SuperHeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
              bottom: 30,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      "Marvel Super Hero\nCharacters",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size.width * 0.060,
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
                Consumer<SuperHeroCharacterDBProvider>(
                  builder: (context, provider, child) {
                    // If the images are not fetched yet, show a loader
                    if (provider.imageUrls.isEmpty) {
                      return Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: AppColors.secondaryColor,
                          size: 22,
                        ),
                      );
                    }

                    // Display images in a grid
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.56,
                      ),
                      itemCount: provider.imageUrls.length,
                      itemBuilder: (context, index) {
                        final imageUrl = provider.imageUrls[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const SuperHeroDescriptionScreen();
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4), // Shadow position
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) => Center(
                                  child: LoadingAnimationWidget.dotsTriangle(
                                    color: AppColors.secondaryColor,
                                    size: 22,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  size: 22,
                                  color: AppColors.secondaryColor,
                                ),
                                fit: BoxFit.cover,
                              ),
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
      ),
    );
  }
}

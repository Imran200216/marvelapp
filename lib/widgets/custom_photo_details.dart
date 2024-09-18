import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';

class CustomPhotoDetails extends StatelessWidget {
  final String placeHolderUrl;
  final String imageUrl;
  final String personName;
  final String personDesignation;
  final List<String> skills;

  const CustomPhotoDetails({
    super.key,
    required this.placeHolderUrl,
    required this.imageUrl,
    required this.personName,
    required this.personDesignation,
    required this.skills, // Required skills
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlipCard(
            fill: Fill.fillBack,
            autoFlipDuration: const Duration(seconds: 4),
            front: Container(
              height: MediaQuery.of(context).size.height * 0.44,
              width: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.44,
                      width: MediaQuery.of(context).size.height * 0.30,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(placeHolderUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ),
            back: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/jpg/details-bg.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Technologies used by person
                    if (skills.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Conditionally show the Flutter icon
                          if (skills.contains("flutter"))
                            SvgPicture.asset(
                              "assets/images/svg/flutter-logo-icon.svg",
                              fit: BoxFit.cover,
                              height: size.height * 0.06,
                            ),
                          if (skills.contains("flutter"))
                            SizedBox(width: size.width * 0.03),

                          // Conditionally show the Figma icon
                          if (skills.contains("figma"))
                            SvgPicture.asset(
                              "assets/images/svg/figma-logo-icon.svg",
                              fit: BoxFit.cover,
                              height: size.height * 0.06,
                            ),
                        ],
                      ),
                    SizedBox(height: size.height * 0.04),

                    /// Name and designation
                    Container(
                      margin: const EdgeInsets.only(left: 14, right: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            personName,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryColor,
                              fontSize: size.width * 0.050,
                              fontFamily: "Poppins",
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            textAlign: TextAlign.center,
                            personDesignation,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.subTitleColor,
                              fontSize: size.width * 0.042,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

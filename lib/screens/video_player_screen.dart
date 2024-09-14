import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
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
                "Marvel Fan Videos",
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
                clipBehavior: Clip.none,
                height: size.height * 0.3,
                width: size.width,
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';


class GetStartedScreen3 extends StatelessWidget {
  const GetStartedScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
          ),
          child: CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            placeholder: (context, url) => Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: AppColors.primaryColor,
                size: 40,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title
              Text(
                "Meet the Legends",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: MediaQuery.of(context).size.width * 0.054,
                  fontFamily: "Poppins",
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              /// subtitle
              Text(
                textAlign: TextAlign.start,
                "Step into the world of Marvel and discover a vast universe filled with extraordinary heroes and notorious villains. Learn about their incredible powers, memorable moments, and the roles they play in shaping the Marvel legacy.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.subTitleColor,
                  fontSize: MediaQuery.of(context).size.width * 0.040,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

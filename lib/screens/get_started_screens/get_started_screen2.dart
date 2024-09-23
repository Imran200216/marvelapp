import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';

class GetStartedScreen2 extends StatelessWidget {
  const GetStartedScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.6,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
          ),
          child: CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1634828221818-503587f33d02?q=80&w=1530&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            placeholder: (context, url) => Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: AppColors.primaryColor,
                size: 40,
              ),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: AppColors.primaryColor,
            ),
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
                "Your Adventure Awaits",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: size.width * 0.054,
                  fontFamily: "Poppins",
                ),
              ),

              SizedBox(
                height: size.height * 0.02,
              ),

              /// subtitle
              Text(
                textAlign: TextAlign.start,
                "Whether you're a longtime fan or new to the world of superheroes, your adventure is just beginning—start now!",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.subTitleColor,
                  fontSize: size.width * 0.040,
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

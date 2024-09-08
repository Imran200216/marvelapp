import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';


class NextContainer extends StatelessWidget {
  final VoidCallback onTap;

  const NextContainer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.060,
        width:  MediaQuery.of(context).size.height * 0.060,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.secondaryColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
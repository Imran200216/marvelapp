import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';

class CustomListTile extends StatelessWidget {
  final String svgAssetLeading;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;
  final Widget? trailing; // Optional trailing widget

  const CustomListTile({
    super.key,
    required this.svgAssetLeading,
    required this.title,
    required this.subTitle,
    this.onTap,
    this.trailing, // Pass optional trailing widget here
  });

  @override
  Widget build(BuildContext context) {
    // Fetching the width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(
        svgAssetLeading,
        height: screenHeight * 0.03,
        width: screenWidth * 0.06,
        color: AppColors.secondaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: screenWidth * 0.032,
          color: AppColors.secondaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: screenWidth * 0.040,
          color: AppColors.secondaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      // Use the trailing widget if provided, otherwise default to an Icon
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: screenWidth * 0.045,
            color: AppColors.secondaryColor,
          ),
    );
  }
}

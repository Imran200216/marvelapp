import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';

class PersonDetailsListTile extends StatelessWidget {
  final String svgPath;
  final String personName;
  final String personDesignation;

  const PersonDetailsListTile(
      {super.key,
      required this.svgPath,
      required this.personName,
      required this.personDesignation});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      leading: SvgPicture.asset(
        "assets/images/svg/$svgPath.svg",
        fit: BoxFit.cover,
        height: size.height * 0.04,
      ),
      title: Text(personName),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.secondaryColor,
        fontSize: size.width * 0.044,
        fontFamily: "Poppins",
      ),
      subtitle: Text(personDesignation),
      subtitleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryColor,
        fontSize: size.width * 0.036,
        fontFamily: "Poppins",
      ),
    );
  }
}

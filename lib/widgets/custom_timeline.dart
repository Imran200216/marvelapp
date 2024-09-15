import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final String title;
  final String subtitle;

  final double lineThickness;
  final EdgeInsetsGeometry padding;
  final bool isFirst;
  final bool isLast;

  const CustomTimelineTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.lineThickness = 2.0,
    this.padding = const EdgeInsets.all(12.0),
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      alignment: TimelineAlign.start,
      lineXY: 0,
      indicatorStyle: IndicatorStyle(
        width: 34,
        height: 34,
        indicator: CachedNetworkImage(
          imageUrl:
              "https://i.pinimg.com/564x/a2/d7/a6/a2d7a6ddce35f2bf9c53fe9fbd22971f.jpg",
          placeholder: (context, url) {
            return LoadingAnimationWidget.dotsTriangle(
              color: AppColors.secondaryColor,
              size: 16,
            );
          },
          imageBuilder: (context, imageProvider) {
            return Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.timeLineBgColor,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        padding: const EdgeInsets.all(4),
      ),
      beforeLineStyle: LineStyle(
        color: AppColors.timeLineBgColor,
        thickness: lineThickness,
      ),
      endChild: Padding(
        padding: padding,
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '$title \n',
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: AppColors.subTitleColor,
                  fontSize: size.width * 0.040,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: subtitle,
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: AppColors.secondaryColor,
                  fontSize: size.width * 0.042,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

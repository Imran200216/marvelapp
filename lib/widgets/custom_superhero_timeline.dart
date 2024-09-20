import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomSuperHeroTimelineTile extends StatelessWidget {
  final String text;

  final double lineThickness;
  final EdgeInsetsGeometry padding;
  final bool isFirst;
  final bool isLast;
  final String imageUrl;

  const CustomSuperHeroTimelineTile({
    super.key,
    required this.text,
    this.lineThickness = 2.0,
    this.padding = const EdgeInsets.all(12.0),
    this.isFirst = false,
    this.isLast = false,
    required this.imageUrl,
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
          imageUrl: imageUrl,
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
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}

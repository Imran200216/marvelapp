import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/app_required_providers/video_player_provider.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return ChangeNotifierProvider(
      create: (context) => VideoPlayerProvider(),
      child: Consumer<VideoPlayerProvider>(
        builder: (context, videoPlayerProvider, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
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
                            height: isPortrait
                                ? size.height * 0.05
                                : size.width * 0.05,
                            width: isPortrait
                                ? size.width * 0.05
                                : size.height * 0.05,
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
                            fontSize: isPortrait
                                ? size.width * 0.050
                                : size.height * 0.050,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: isPortrait ? 16 / 9 : 16 / 10,
                              child: Chewie(
                                controller:
                                    videoPlayerProvider.chewieController,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

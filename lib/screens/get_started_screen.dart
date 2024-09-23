import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/screens_providers/get_started_provider.dart';
import 'package:marvelapp/screens/auth_selection_screen.dart';
import 'package:marvelapp/screens/get_started_screens/get_started_screen1.dart';
import 'package:marvelapp/screens/get_started_screens/get_started_screen2.dart';
import 'package:marvelapp/screens/get_started_screens/get_started_screen3.dart';
import 'package:marvelapp/widgets/next_container.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<GetStartedProvider>(
      builder: (
        context,
        getStartedProvider,
        child,
      ) {
        return DoubleTapToExit(
          snackBar: SnackBar(
            backgroundColor: AppColors.timeLineBgColor,
            content: Text(
              "Tag again to exit!",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: size.width * 0.040,
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.secondaryColor,
              bottomSheet: Container(
                color: AppColors.secondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Smooth Page Indicator
                    SmoothPageIndicator(
                      controller: getStartedProvider.pageController,
                      // Use provider's page controller
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColors.primaryColor,
                        dotColor: Colors.grey.shade300,
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 3,
                      ),
                    ),

                    /// Next Icon
                    NextContainer(
                      onTap: () {
                        // If on the last page, navigate to AuthScreen
                        if (getStartedProvider.currentPage == 2) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const AuthSelectionScreen();
                          }));
                        } else {
                          getStartedProvider.nextPage();
                        }
                      },
                    ),
                  ],
                ),
              ),
              body: Container(
                padding: const EdgeInsets.only(
                  bottom: 80,
                ),
                child: PageView(
                  controller: getStartedProvider.pageController,
                  // Use provider's page controller
                  onPageChanged: (int page) {
                    // Update the current page in provider when swiping
                    getStartedProvider.setPage(page);
                  },
                  children: const [
                    GetStartedScreen1(),
                    GetStartedScreen2(),
                    GetStartedScreen3(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

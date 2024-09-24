import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/screens_providers/bottom_nav_provider.dart';
import 'package:marvelapp/screens/bottom_nav_screens/home_screen.dart';
import 'package:marvelapp/screens/bottom_nav_screens/profile_screen.dart';
import 'package:marvelapp/screens/bottom_nav_screens/super_hero_screen.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  /// Bottom navigation bar screens
  final List<Widget> widgetList = [
    const HomeScreen(),
    const SuperHeroScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<BottomNavProvider>(
      builder: (context, bottomNavProvider, child) {
        return WillPopScope(
          onWillPop: () async {
            if (bottomNavProvider.currentIndex != 0) {
              // If not on the first screen, go to the previous screen
              bottomNavProvider.setIndex(0);
              return false;
            } else {
              // Allow the app to be popped (exit) if already on the first screen
              return true;
            }
          },
          child: DoubleTapToExit(
            snackBar: SnackBar(
              backgroundColor: AppColors.timeLineBgColor,
              content: Text(
                "Tap again to exit!",
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
                backgroundColor: AppColors.primaryColor,

                /// Bottom navigation bar
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (index) {
                    bottomNavProvider.setIndex(index);
                  },
                  backgroundColor: AppColors.primaryColor,
                  currentIndex: bottomNavProvider.currentIndex,
                  selectedItemColor: AppColors.secondaryColor,
                  unselectedItemColor: AppColors.subTitleColor,
                  unselectedLabelStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: AppColors.subTitleColor,
                  ),
                  selectedLabelStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor,
                  ),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/svg/movie-icon.svg',
                        color: bottomNavProvider.currentIndex == 0
                            ? AppColors.secondaryColor
                            : AppColors.subTitleColor,
                        height: 24,
                        width: 24,
                      ),
                      label: 'Movies',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/svg/super-hero-icon.svg',
                        color: bottomNavProvider.currentIndex == 1
                            ? AppColors.secondaryColor
                            : AppColors.subTitleColor,
                        height: 24,
                        width: 24,
                      ),
                      label: 'Super Heros',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/svg/profile-icon.svg',
                        color: bottomNavProvider.currentIndex == 2
                            ? AppColors.secondaryColor
                            : AppColors.subTitleColor,
                        height: 24,
                        width: 24,
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),

                body: IndexedStack(
                  index: bottomNavProvider.currentIndex,
                  children: widgetList,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

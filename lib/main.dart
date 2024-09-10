import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/provider/bottom_nav_provider.dart';
import 'package:marvelapp/provider/get_started_provider.dart';
import 'package:marvelapp/provider/internet_checker_provider.dart';

import 'package:marvelapp/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// get started provider
        ChangeNotifierProvider(
          create: (_) => GetStartedProvider(),
        ),

        /// bottom nav provider
        ChangeNotifierProvider(
          create: (_) => BottomNavProvider(),
        ),

        /// internet checker provider
        ChangeNotifierProvider(
          create: (_) => InternetCheckerProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/firebase_options.dart';
import 'package:marvelapp/provider/app_required_providers/app_version_provider.dart';
import 'package:marvelapp/provider/app_required_providers/conversion_provider.dart';
import 'package:marvelapp/provider/app_required_providers/in_app_review_provider.dart';
import 'package:marvelapp/provider/app_required_providers/internet_checker_provider.dart';
import 'package:marvelapp/provider/app_required_providers/url_launcher_provider.dart';
import 'package:marvelapp/provider/authentication_providers/email_auth_provider.dart';
import 'package:marvelapp/provider/authentication_providers/guest_auth_provider.dart';
import 'package:marvelapp/provider/screens_providers/bottom_nav_provider.dart';
import 'package:marvelapp/provider/db_provider/marvel_movie_db_provider.dart';
import 'package:marvelapp/provider/screens_providers/character_modal_provider.dart';
import 'package:marvelapp/provider/screens_providers/get_started_provider.dart';
import 'package:marvelapp/provider/db_provider/super_hero_character_db_provider.dart';
import 'package:marvelapp/provider/user_details_provider/email_user_details_provider.dart';
import 'package:marvelapp/provider/user_details_provider/guest_user_details_provider.dart';
import 'package:marvelapp/provider/authentication_providers/password_visibility_provider.dart';
import 'package:marvelapp/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// firebase app check
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );

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

        /// auth provider (guest provider)
        ChangeNotifierProvider(
          create: (_) => GuestAuthenticationProvider(),
        ),

        /// auth provider (email provider)
        ChangeNotifierProvider(
          create: (_) => EmailAuthenticationProvider(),
        ),

        /// password visibility provider
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),

        /// guest user details provider
        ChangeNotifierProvider(
          create: (_) => GuestUserDetailsProvider(),
        ),

        /// email user details provider
        ChangeNotifierProvider(
          create: (_) => EmailUserDetailsProvider(),
        ),

        /// super hero character db provider
        ChangeNotifierProvider(
          create: (_) => SuperHeroCharacterDBProvider(),
        ),

        /// app version provider
        ChangeNotifierProvider(
          create: (_) => AppVersionProvider(),
        ),

        /// marvel movie db provider
        ChangeNotifierProvider(
          create: (_) => MarvelMoviesProvider(),
        ),

        /// conversion provider
        ChangeNotifierProvider(
          create: (_) => ConversionProvider(),
        ),

        /// url launcher provider
        ChangeNotifierProvider(
          create: (_) => UrlLauncherProvider(),
        ),

        /// character modal provider
        ChangeNotifierProvider(
          create: (_) => CharacterModelProvider(),
        ),

        /// review provider
        ChangeNotifierProvider(
          create: (_) => InAppReviewProvider(),
        ),
      ],
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: TextTheme(
              /// super hero description text
              bodySmall: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.subTitleColor,
                fontFamily: "Poppins",
                fontSize: size.width * 0.038,
              ),

              /// home title & super hero title
              titleLarge: TextStyle(
                fontFamily: "Poppins",
                fontSize: size.width * 0.052,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColor,
              ),
            ),

            /// colors schemes
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
            ),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

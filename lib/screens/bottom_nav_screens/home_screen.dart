import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/modals/mcu_modals.dart';
import 'package:marvelapp/provider/internet_checker_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var marvelApi = "https://mcuapi.herokuapp.com/api/v1/movies";
  List<McuModal> mcuMoviesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarvelMovies();
  }

  @override
  Widget build(BuildContext context) {
    // Getting the size of the screen

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<InternetCheckerProvider>(
          builder: (
            context,
            internetCheckerProvider,
            child,
          ) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 30,
                  bottom: 30,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Cool Nick names\nfor your profile",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size.width * 0.060,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    !internetCheckerProvider.isNetworkConnected
                        ? Center(
                            child: Lottie.asset(
                              'assets/images/animation/network-error-animation.json',
                              height: size.height * 0.5,
                              width: size.width * 0.8,
                              fit: BoxFit.cover,
                            ),
                          )
                        : mcuMoviesList.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: mcuMoviesList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 2 / 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: mcuMoviesList[index].coverUrl != null
                                        ? CachedNetworkImage(
                                            imageUrl: mcuMoviesList[index]
                                                .coverUrl
                                                .toString(),
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/svg/marvel-placeholder.svg",
                                            fit: BoxFit.cover,
                                            height: 80,
                                            width: 80,
                                          ),
                                  );
                                },
                              )
                            : Center(
                                child: LoadingAnimationWidget.dotsTriangle(
                                  color: AppColors.secondaryColor,
                                  size: 50,
                                ),
                              ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void getMarvelMovies() {
    debugPrint("======== Function running =========");

    final uri = Uri.parse(marvelApi);
    http.get(uri).then((response) {
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodedData = jsonDecode(responseBody);
        print(responseBody);
        print(decodedData['data']);

        final List marvelData = decodedData['data'];

        for (var i = 0; i < marvelData.length; i++) {
          final mcuMovie =
              McuModal.fromJson(marvelData[i] as Map<String, dynamic>);

          mcuMoviesList.add(mcuMovie);
        }
        setState(() {});
      } else {}
    }).catchError((err) {
      debugPrint("==========   $err   =========");
    });
  }
}

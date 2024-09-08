import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/modals/mcu_modals.dart';

class DummyScreen extends StatefulWidget {
  const DummyScreen({super.key});

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: mcuMoviesList.isNotEmpty
            ? GridView.builder(
                itemCount: mcuMoviesList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                            imageUrl: mcuMoviesList[index].coverUrl.toString(),
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
                  color: Colors.black,
                  size: 50,
                ),
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

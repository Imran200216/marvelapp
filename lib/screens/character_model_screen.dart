import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';

import 'package:model_viewer_plus/model_viewer_plus.dart';

class CharacterModelScreen extends StatelessWidget {
  const CharacterModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          title: const Text("Spider-Man"),
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: AppColors.secondaryColor,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.zero,
              image: DecorationImage(
                image: NetworkImage(
                  "https://i.pinimg.com/564x/6e/81/8a/6e818a28908e622097199f9c9f002a6b.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Make the container height fit the content rather than the entire screen
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const ModelViewer(
                      src: "assets/images/3d_modal/ironman-modal.glb",
                      autoRotate: false,
                      autoPlay: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

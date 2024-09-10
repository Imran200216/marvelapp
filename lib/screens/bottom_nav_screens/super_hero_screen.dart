import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/screens/character_model_screen.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SuperHeroScreen extends StatelessWidget {
  const SuperHeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Marvel character image
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.zero,
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://i.pinimg.com/736x/cd/0d/05/cd0d0588e15b584d146560573104bf74.jpg",
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: AppColors.primaryColor,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 0,
                  bottom: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// character name
                    TimelineTile(
                      alignment: TimelineAlign.start,
                      // Aligns to start of the paragraph
                      lineXY: 0,
                      // Align the timeline to the start
                      isFirst: true,

                      indicatorStyle: const IndicatorStyle(
                        width: 34,
                        height: 34,
                        indicator: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://i.pinimg.com/564x/69/cc/c6/69ccc6d366ee195d4fec94f51a96539c.jpg",
                          ),
                        ),
                        padding: EdgeInsets.all(4),
                      ),
                      beforeLineStyle: LineStyle(
                        color: AppColors.timeLineBgColor,
                        thickness: 2,
                      ),
                      endChild: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Spider-Man",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondaryColor,
                            fontSize: MediaQuery.of(context).size.width * 0.064,
                          ),
                        ),
                      ),
                    ),

                    /// Timeline Tile for the first paragraph
                    TimelineTile(
                      alignment: TimelineAlign.start,
                      // Aligns to start of the paragraph
                      lineXY: 0,

                      indicatorStyle: const IndicatorStyle(
                        width: 34,
                        height: 34,
                        indicator: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://i.pinimg.com/564x/69/cc/c6/69ccc6d366ee195d4fec94f51a96539c.jpg",
                          ),
                        ),
                        padding: EdgeInsets.all(4),
                      ),
                      beforeLineStyle: LineStyle(
                        color: AppColors.timeLineBgColor,
                        thickness: 2,
                      ),
                      endChild: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          '''
Spider-Man, created by writer Stan Lee and artist Steve Ditko, made his debut in Amazing Fantasy #15 in 1962. His real identity is Peter Parker, a teenager living in New York City who gains superhuman abilities after being bitten by a radioactive spider. With powers including super strength, the ability to stick to walls, and a "spidey sense" that warns him of danger, Spider-Man is one of the most iconic and relatable superheroes.
                          ''',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.subTitleColor,
                            fontFamily: "Poppins",
                            fontSize: MediaQuery.of(context).size.width * 0.038,
                          ),
                        ),
                      ),
                    ),

                    /// Timeline Tile for the second paragraph
                    TimelineTile(
                      alignment: TimelineAlign.start,
                      // Aligns to start of the paragraph
                      lineXY: 0,
                      // Align the timeline to the start
                      isLast: true,
                      indicatorStyle: const IndicatorStyle(
                        width: 34,
                        height: 34,
                        indicator: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://i.pinimg.com/564x/69/cc/c6/69ccc6d366ee195d4fec94f51a96539c.jpg",
                          ),
                        ),
                        padding: EdgeInsets.all(4),
                      ),
                      beforeLineStyle: LineStyle(
                        color: AppColors.timeLineBgColor,
                        thickness: 2,
                      ),
                      endChild: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          '''
What sets Spider-Man apart is his famous moral lesson: "With great power comes great responsibility," instilled in him by his Uncle Ben's death. This philosophy drives his actions as a superhero, as he balances protecting his city with his personal life. His notable enemies include the Green Goblin, Doctor Octopus, and Venom, and he is a key member of the Marvel Universe, often teaming up with the Avengers.
                          ''',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: AppColors.subTitleColor,
                            fontSize: MediaQuery.of(context).size.width * 0.038,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: NeoPopButton(
                        color: AppColors.secondaryColor,
                        onTapUp: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const CharacterModelScreen();
                          }));
                        },
                        onTapDown: () => HapticFeedback.vibrate(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/svg/super-hero-icon.svg",
                                height:
                                    MediaQuery.of(context).size.height * 0.030,
                                width:
                                    MediaQuery.of(context).size.width * 0.030,
                                color: AppColors.primaryColor,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              Text(
                                "View 3d character model",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.038,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

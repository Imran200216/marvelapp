import 'package:cloud_firestore/cloud_firestore.dart';

class SuperHeroCharacter {
  final String characterName;
  final String characterCoverUrl;
  final String indicatorPhotoUrl;
  final String characterPara1;
  final String characterPara2;
  final String characterCardPhotoUrl;

  SuperHeroCharacter({
    required this.characterName,
    required this.characterCoverUrl,
    required this.indicatorPhotoUrl,
    required this.characterPara1,
    required this.characterPara2,
    required this.characterCardPhotoUrl,
  });



  // Convert SuperHeroCharacter instance to map
  Map<String, dynamic> toMap() {
    return {
      'characterName': characterName,
      'characterCoverUrl': characterCoverUrl,
      'indicatorPhotoUrl': indicatorPhotoUrl,
      'characterPara1': characterPara1,
      'characterPara2': characterPara2,
      'characterCardPhotoUrl': characterCardPhotoUrl,
    };
  }
}

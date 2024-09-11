class SuperHeroModal {
  String? characterName;
  String? characterFactPara1;
  String? characterFactPara2;
  String? characterCoverPhotoUrl;
  String? characterTimeLinePhotoUrl;
  String? character3dModelUrl;
  String? character3dModelBgUrl;

  // Constructor with all fields optional
  SuperHeroModal({
    this.characterName,
    this.characterFactPara1,
    this.characterFactPara2,
    this.characterCoverPhotoUrl,
    this.characterTimeLinePhotoUrl,
    this.character3dModelUrl,
    this.character3dModelBgUrl,
  });

  // Convert a SuperHeroModal object into a Map (for Fire store or JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'characterName': characterName,
      'characterFactPara1': characterFactPara1,
      'characterFactPara2': characterFactPara2,
      'characterCoverPhotoUrl': characterCoverPhotoUrl,
      'characterTimeLinePhotoUrl': characterTimeLinePhotoUrl,
      'character3dModelUrl': character3dModelUrl,
      'character3dModelBgUrl': character3dModelBgUrl,
    };
  }

  // Create a SuperHeroModal object from a Map (for Fire store or JSON deserialization)
  factory SuperHeroModal.fromJson(Map<String, dynamic> json) {
    return SuperHeroModal(
      characterName: json['characterName'],
      characterFactPara1: json['characterFactPara1'],
      characterFactPara2: json['characterFactPara2'],
      characterCoverPhotoUrl: json['characterCoverPhotoUrl'],
      characterTimeLinePhotoUrl: json['characterTimeLinePhotoUrl'],
      character3dModelUrl: json['character3dModelUrl'],
      character3dModelBgUrl: json['character3dModelBgUrl'],
    );
  }
}

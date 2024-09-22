class UserModal {
  String? uid;
  String? userName;
  String? nickName;
  String? userEmail;
  String? userPhotoURL;
  String? avatarPhotoURL;
  bool? hasReviewed;

  UserModal({
    this.uid,
    this.userName,
    this.nickName,
    this.userEmail,
    this.userPhotoURL,
    this.avatarPhotoURL,
    this.hasReviewed,
  });

  /// Convert a UserModal object into a Map (for Firestore or JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'nickName': nickName,
      'userEmail': userEmail,
      'userPhotoURL': userPhotoURL,
      'avatarPhotoURL': avatarPhotoURL,
      'hasReviewed': hasReviewed ?? false, // Ensure default value if null
    };
  }

  /// Create a UserModal object from a Map (for Firestore or JSON deserialization)
  factory UserModal.fromJson(Map<String, dynamic> json) {
    return UserModal(
      uid: json['uid'],
      userName: json['userName'],
      nickName: json['nickName'],
      userEmail: json['userEmail'],
      userPhotoURL: json['userPhotoURL'],
      avatarPhotoURL: json['avatarPhotoURL'],
      hasReviewed: json['hasReviewed'] ?? false, // Default to false if null
    );
  }
}

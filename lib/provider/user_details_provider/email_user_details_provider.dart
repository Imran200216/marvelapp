import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/screens/bottom_nav.dart';
import 'package:marvelapp/widgets/toast_helper.dart';

class EmailUserDetailsProvider extends ChangeNotifier {
  List<String> _imageUrls = [];
  String? selectedAvatarURL;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> get imageUrls => _imageUrls;

  Future<void> fetchAvatars() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('avatars');
      final listResult = await storageRef.listAll();
      final urls = await Future.wait(
        listResult.items.map((ref) => ref.getDownloadURL()),
      );

      _imageUrls = urls;
      notifyListeners();
    } catch (e) {
      print('Failed to load avatars: $e');
    }
  }

  // Method to set the selected avatar and update Firebase
  Future<void> setSelectedAvatar(String avatarUrl, BuildContext context) async {
    selectedAvatarURL = avatarUrl;
    notifyListeners(); // Notify listeners to update the UI

    // Get the current user's UID
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // This can be either an anonymous user or a registered user
      String uid = user.uid;

      // Update the avatarPhotoURL field in Fire store using the UID as the document ID
      await _firestore
          .collection('userByEmailAuth')
          .doc(uid)
          .update({'avatarPhotoURL': avatarUrl}).then((value) {
        /// success toast
        ToastHelper.showSuccessToast(
          context: context,
          message: "Avatar added successfully!",
        );
      });
    } else {
      // Handle the case where the user is not authenticated
      // Show a toast message if the nickname is empty
      ToastHelper.showErrorToast(
        context: context,
        message: "Avatar should be added!",
      );
      print('No user is signed in');
    }
    notifyListeners();
  }

  // Controller for the nickname TextField
  final TextEditingController nicknameControllerByEmail =
      TextEditingController();

  // Method to set the nickname and update Firestore
  Future<void> setNickname(BuildContext context) async {
    final nickName = nicknameControllerByEmail.text.trim();

    // Ensure the nickname is not empty
    if (nickName.isNotEmpty) {
      final User? user = FirebaseAuth.instance.currentUser;

      // Validate if nickname is empty
      if (nickName.isEmpty) {
        // Show a toast message if the nickname is empty
        ToastHelper.showErrorToast(
          context: context,
          message: "Nickname cannot be empty!",
        );

        return;
      }

      if (user != null) {
        String uid = user.uid;

        // Update the nickName field in Firestore using the UID
        await _firestore
            .collection('userByEmailAuth')
            .doc(uid) // Use the user's UID
            .update({'nickName': nickName});

        /// success toast
        ToastHelper.showSuccessToast(
          context: context,
          message: "Nickname added successfully!",
        );

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return BottomNavBar();
        }));

        notifyListeners(); // Notify listeners in case of changes
      } else {
        print('No user is signed in');
      }
    } else {
      print('Nickname is empty');
    }
  }

  String? _nickname;
  String? _avatarPhotoURL;

  String? get nickname => _nickname;

  String? get avatarPhotoURL => _avatarPhotoURL;

  // Fetch guest user details from Firestore
  Future<void> fetchEmailUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      String uid = user.uid;

      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('userByEmailAuth').doc(uid).get();

        if (userDoc.exists) {
          _nickname = userDoc['nickName'] ?? 'No nickname';
          _avatarPhotoURL = userDoc['avatarPhotoURL'] ??
              'https://example.com/default-avatar.png'; // Add a default URL
        } else {
          print('Guest user document does not exist');
        }
      } catch (e) {
        print('Failed to fetch email user details: $e');
      }
    }

    notifyListeners();
  }
}

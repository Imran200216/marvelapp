import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/widgets/toast_helper.dart';

class EmailUserDetailsProvider extends ChangeNotifier {
  List<String> _imageUrls = [];
  String? selectedAvatarURL;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> get imageUrls => _imageUrls;

  String? _nickname;
  String? _avatarPhotoURL;

  String? get nickname => _nickname;

  String? get avatarPhotoURL => _avatarPhotoURL;

  // Fetch avatars from Firebase Storage
  Future<void> fetchAvatars() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('avatars');
      final listResult = await storageRef.listAll();
      final urls = await Future.wait(
        listResult.items.map((ref) => ref.getDownloadURL()),
      );

      _imageUrls = urls;
      notifyListeners(); // Notify UI of changes
    } catch (e) {
      print('Failed to load avatars: $e');
    }
  }

  // Set and update selected avatar in Firestore
  Future<void> setSelectedAvatar(String avatarUrl, BuildContext context) async {
    selectedAvatarURL = avatarUrl;
    notifyListeners(); // Immediately notify UI about avatar change

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      // Update avatar in Firestore
      await _firestore
          .collection('userByEmailAuth')
          .doc(uid)
          .update({'avatarPhotoURL': avatarUrl}).then((value) {
        ToastHelper.showSuccessToast(
          context: context,
          message: "Avatar added successfully!",
        );
      });

      fetchEmailUserDetails(); // Ensure updated data is fetched
    } else {
      ToastHelper.showErrorToast(
        context: context,
        message: "No user signed in.",
      );
    }
  }

  // Set and update nickname in Firestore
  final TextEditingController nicknameControllerByEmail =
      TextEditingController();

  Future<void> setNickname(BuildContext context) async {
    final nickName = nicknameControllerByEmail.text.trim();

    if (nickName.isNotEmpty) {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        // Update the nickname in Firestore
        await _firestore
            .collection('userByEmailAuth')
            .doc(uid)
            .update({'nickName': nickName}).then((value) {
          ToastHelper.showSuccessToast(
            context: context,
            message: "Nickname updated successfully!",
          );
        });

        // Fetch updated data to reflect it in the UI
        fetchEmailUserDetails();
      } else {
        ToastHelper.showErrorToast(
          context: context,
          message: "No user signed in.",
        );
      }
    } else {
      ToastHelper.showErrorToast(
        context: context,
        message: "Nickname cannot be empty!",
      );
    }
  }

  // Fetch user details from Firestore
  Future<void> fetchEmailUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.isAnonymous) {
      String uid = user.uid;

      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('userByEmailAuth').doc(uid).get();

        if (userDoc.exists) {
          _nickname = userDoc['nickName'] ?? 'No nickname';
          _avatarPhotoURL = userDoc['avatarPhotoURL'] ??
              'https://example.com/default-avatar.png';

          // Notify listeners after updating data
          notifyListeners();
        } else {
          print('User document does not exist');
        }
      } catch (e) {
        print('Failed to fetch email user details: $e');
      }
    }
  }
}

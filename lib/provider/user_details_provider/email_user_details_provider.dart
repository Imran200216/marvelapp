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

  String? _nickname;
  String? _avatarPhotoURL;

  String? get nickname => _nickname;

  String? get avatarPhotoURL => _avatarPhotoURL;

  bool _isAvatarUpdated = false; // Flag to track avatar update
  bool get isAvatarUpdated => _isAvatarUpdated;

  bool _isLoading = false; // Loading state flag
  bool get isLoading => _isLoading;

  // Flag to check if avatars have already been loaded
  bool _avatarsFetched = false;

  // Fetch avatars from Firebase Storage (only once)
  Future<void> fetchAvatars() async {
    // Check if avatars have already been fetched to prevent multiple fetches
    if (_avatarsFetched) return; // Return early if avatars are already cached

    try {
      final storageRef = FirebaseStorage.instance.ref().child('avatars');
      final listResult = await storageRef.listAll();
      final urls = await Future.wait(
        listResult.items.map((ref) => ref.getDownloadURL()),
      );

      _imageUrls = urls;
      _avatarsFetched = true; // Mark avatars as fetched
      notifyListeners();
    } catch (e) {
      print('Failed to load avatars: $e');
    }
  }

  // Set and update selected avatar in Firestore
  Future<void> setSelectedAvatar(String avatarUrl, BuildContext context) async {
    selectedAvatarURL = avatarUrl;
    notifyListeners(); // Notify UI about avatar change immediately

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      // Update avatar in Firestore
      await _firestore.collection('userByEmailAuth').doc(uid).update({
        'avatarPhotoURL': avatarUrl,
      }).then((value) async {
        _isAvatarUpdated = true;

        // Wait until the avatar is updated and the details are fetched before notifying the UI
        await fetchEmailUserDetails();

        // Display the success toast after everything is done
        ToastHelper.showSuccessToast(
          context: context,
          message: "Avatar added successfully!",
        );

        notifyListeners(); // Now notify UI about avatar update
      }).catchError((error) {
        ToastHelper.showErrorToast(
          context: context,
          message: "Failed to update avatar: $error",
        );
      });
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

        // Set loading state to true
        _isLoading = true;
        notifyListeners();

        try {
          // Update the nickname in Firestore
          await _firestore
              .collection('userByEmailAuth')
              .doc(uid)
              .update({'nickName': nickName});
          ToastHelper.showSuccessToast(
              context: context, message: "Nickname updated successfully!");

          // Navigate to BottomNavBar
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return BottomNavBar();
          }));
        } catch (e) {
          ToastHelper.showErrorToast(
              context: context, message: "Failed to update nickname.");
        } finally {
          // Set loading state to false after the operation completes
          _isLoading = false;
          notifyListeners();
        }
      } else {
        ToastHelper.showErrorToast(
            context: context, message: "No user signed in.");
      }
    } else {
      ToastHelper.showErrorToast(
          context: context, message: "Nickname cannot be empty!");
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

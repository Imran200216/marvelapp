import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/screens/bottom_nav.dart';
import 'package:marvelapp/widgets/toast_helper.dart';

class ProfileAvatarGuestEditProvider extends ChangeNotifier {
  List<String> _imageUrls = [];
  String? _nickname;
  String? _avatarPhotoURL;
  String? selectedAvatarURL;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false; // Loading flag
  bool get isLoading => _isLoading; // Getter to expose loading status

  // Getters for nickname and avatar URL
  String? get nickname => _nickname;

  String? get avatarPhotoURL => _avatarPhotoURL;

  List<String> get imageUrls => _imageUrls;

  bool _isAvatarUpdated = false; // Add this flag to track avatar update
  bool get isAvatarUpdated => _isAvatarUpdated; // Expose this flag to UI

  // Fetch avatars from Firebase Storage
  Future<void> fetchAvatars() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('avatars');
      final listResult = await storageRef.listAll();
      final urls = await Future.wait(
        listResult.items.map((ref) => ref.getDownloadURL()),
      );

      _imageUrls = urls;
      notifyListeners(); // Notify listeners to update the UI
    } catch (e) {
      print('Failed to load avatars: $e');
    }
  }

  // Set selected avatar and update in Firestore
  Future<void> setSelectedAvatar(String avatarUrl, BuildContext context) async {
    selectedAvatarURL = avatarUrl;
    notifyListeners(); // Update the UI immediately

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      String uid = user.uid;

      try {
        // Update Firestore with the new avatar URL
        await _firestore.collection('userByGuestAuth').doc(uid).set({
          'avatarPhotoURL': avatarUrl,
        }, SetOptions(merge: true)).then((value) async {
          _isAvatarUpdated = true;

          // Refetch guest details after update to reflect changes
          await fetchGuestUserDetails();

          ToastHelper.showSuccessToast(
            context: context,
            message: "Avatar updated successfully!",
          );

          notifyListeners(); // Notify UI of update
        });
      } catch (e) {
        ToastHelper.showErrorToast(
          context: context,
          message: "Failed to update avatar.",
        );
        print('Error updating avatar: $e');
      }
    } else {
      ToastHelper.showErrorToast(
        context: context,
        message: "No user signed in.",
      );
      print('No user signed in');
    }
  }

  // Controller for nickname TextField
  final TextEditingController nicknameControllerByGuest =
      TextEditingController();

  // Set nickname and update in Firestore
  Future<void> setNickname(BuildContext context) async {
    final nickName = nicknameControllerByGuest.text.trim();

    if (nickName.isEmpty) {
      ToastHelper.showErrorToast(
        context: context,
        message: "Nickname cannot be empty!",
      );
      return;
    }

    _isLoading = true; // Start loading
    notifyListeners(); // Notify UI to show progress indicator

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      String uid = user.uid;

      try {
        // Update Firestore with the new nickname
        await _firestore.collection('userByGuestAuth').doc(uid).set({
          'nickName': nickName,
        }, SetOptions(merge: true)).then((value) async {
          ToastHelper.showSuccessToast(
            context: context,
            message: "Nickname updated successfully!",
          );

          // Navigate to BottomNavBar
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return BottomNavBar();
          }));
        });
      } catch (e) {
        ToastHelper.showErrorToast(
          context: context,
          message: "Failed to update nickname.",
        );
        print('Error updating nickname: $e');
      } finally {
        _isLoading = false; // Stop loading
        notifyListeners(); // Notify UI to hide progress indicator
      }
    } else {
      ToastHelper.showErrorToast(
        context: context,
        message: "No user signed in.",
      );
      print('No user signed in');
    }
  }

  // Fetch guest user details from Firestore
  Future<void> fetchGuestUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      String uid = user.uid;

      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('userByGuestAuth').doc(uid).get();

        if (userDoc.exists) {
          _nickname = userDoc['nickName'] ?? 'No nickname';
          _avatarPhotoURL = userDoc['avatarPhotoURL'] ??
              'https://example.com/default-avatar.png'; // Fallback URL
          notifyListeners(); // Notify UI of data change
        } else {
          print('Guest user document does not exist');
        }
      } catch (e) {
        print('Failed to fetch guest user details: $e');
      }
    }
  }
}

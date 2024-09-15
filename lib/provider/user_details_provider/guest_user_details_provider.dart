import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:marvelapp/screens/bottom_nav.dart';

class GuestUserDetailsProvider extends ChangeNotifier {
  List<String> _imageUrls = [];
  String? _nickname;
  String? _avatarPhotoURL;
  String? selectedAvatarURL;
  bool _isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getters for external access
  String? get nickname => _nickname;

  String? get avatarPhotoURL => _avatarPhotoURL;

  List<String> get imageUrls => _imageUrls;

  bool get isLoading => _isLoading;

  // Fetch avatars from Firebase Storage
  Future<void> fetchAvatars() async {
    _setLoading(true);
    try {
      final storageRef = FirebaseStorage.instance.ref().child('avatars');
      final listResult = await storageRef.listAll();
      final urls = await Future.wait(
        listResult.items.map((ref) => ref.getDownloadURL()),
      );

      _imageUrls = urls;
      _notifyListenersSafely(); // Notify safely
    } catch (e) {
      print('Failed to load avatars: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Set selected avatar and update in Firestore
  Future<void> setSelectedAvatar(String avatarUrl, BuildContext context) async {
    selectedAvatarURL = avatarUrl;
    _notifyListenersSafely(); // Notify safely

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      String uid = user.uid;

      _setLoading(true);
      try {
        await _firestore.collection('userByGuestAuth').doc(uid).update({
          'avatarPhotoURL': avatarUrl,
        }).then((value) {
          ToastHelper.showSuccessToast(
            context: context,
            message: "Avatar updated successfully!",
          );
        });

        await fetchGuestUserDetails();
      } catch (e) {
        ToastHelper.showErrorToast(
          context: context,
          message: "Failed to update avatar.",
        );
        print('Error updating avatar: $e');
      } finally {
        _setLoading(false);
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

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      String uid = user.uid;

      _setLoading(true);
      try {
        await _firestore.collection('userByGuestAuth').doc(uid).update({
          'nickName': nickName,
        }).then((value) {
          ToastHelper.showSuccessToast(
            context: context,
            message: "Nickname updated successfully!",
          );
        });

        await fetchGuestUserDetails();
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return BottomNavBar();
          },
        ));
      } catch (e) {
        ToastHelper.showErrorToast(
          context: context,
          message: "Failed to update nickname.",
        );
        print('Error updating nickname: $e');
      } finally {
        _setLoading(false);
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

      _setLoading(true);
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('userByGuestAuth').doc(uid).get();

        if (userDoc.exists) {
          _nickname = userDoc['nickName'] ?? 'No nickname';
          _avatarPhotoURL = userDoc['avatarPhotoURL'] ??
              'https://example.com/default-avatar.png'; // Fallback URL
          _notifyListenersSafely(); // Notify safely
        } else {
          print('Guest user document does not exist');
        }
      } catch (e) {
        print('Failed to fetch guest user details: $e');
      } finally {
        _setLoading(false);
      }
    }
  }

  // Method to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    _notifyListenersSafely(); // Notify safely
  }

  // Notify listeners safely
  void _notifyListenersSafely() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isLoading) {
        notifyListeners();
      }
    });
  }
}

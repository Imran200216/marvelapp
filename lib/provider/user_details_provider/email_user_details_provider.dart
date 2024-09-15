import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/screens/bottom_nav.dart';
import 'package:marvelapp/widgets/toast_helper.dart';

class EmailUserDetailsProvider extends ChangeNotifier {
  List<String> _imageUrls = [];
  String? selectedAvatarURL;
  bool _isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> get imageUrls => _imageUrls;

  String? get nickname => _nickname;

  String? get avatarPhotoURL => _avatarPhotoURL;

  bool get isLoading => _isLoading;

  String? _nickname;
  String? _avatarPhotoURL;

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
      notifyListeners(); // Notify UI of changes
    } catch (e) {
      print('Failed to load avatars: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Set and update selected avatar in Firestore
  Future<void> setSelectedAvatar(String avatarUrl, BuildContext context) async {
    selectedAvatarURL = avatarUrl;
    notifyListeners(); // Immediately notify UI about avatar change

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      _setLoading(true);
      try {
        await _firestore.collection('userByEmailAuth').doc(uid).update({
          'avatarPhotoURL': avatarUrl,
        }).then((value) {
          ToastHelper.showSuccessToast(
            context: context,
            message: "Avatar added successfully!",
          );
        });

        await fetchEmailUserDetails(); // Ensure updated data is fetched
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

        _setLoading(true);
        try {
          await _firestore.collection('userByEmailAuth').doc(uid).update({
            'nickName': nickName,
          }).then((value) {
            ToastHelper.showSuccessToast(
              context: context,
              message: "Nickname updated successfully!",
            );

            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return BottomNavBar();
              },
            ));
          });

          await fetchEmailUserDetails(); // Fetch updated data to reflect it in the UI
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

      _setLoading(true);
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('userByEmailAuth').doc(uid).get();

        if (userDoc.exists) {
          _nickname = userDoc['nickName'] ?? 'No nickname';
          _avatarPhotoURL = userDoc['avatarPhotoURL'] ??
              'https://example.com/default-avatar.png';

          notifyListeners(); // Notify listeners after updating data
        } else {
          print('User document does not exist');
        }
      } catch (e) {
        print('Failed to fetch email user details: $e');
      } finally {
        _setLoading(false);
      }
    }
  }

  // Method to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

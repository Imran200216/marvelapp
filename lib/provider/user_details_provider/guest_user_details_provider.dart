import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class GuestUserDetailsProvider extends ChangeNotifier {
  List<String> _imageUrls = [];

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
}

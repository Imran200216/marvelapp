import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SuperHeroCharacterDBProvider extends ChangeNotifier {
  List<String> _imageUrls = [];

  List<String> get imageUrls => _imageUrls;

  // Fetch avatars from Firebase Storage
  Future<void> fetchAvatars() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('superheros');
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

  // Fetch data immediately when this provider is created
  SuperHeroCharacterDBProvider() {
    fetchAvatars();
  }
}

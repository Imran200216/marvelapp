import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuperHeroCharacterDBProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _superHeroes = [];

  List<Map<String, dynamic>> get superHeroes => _superHeroes;

  // Fetch superhero details from Fire store
  Future<void> fetchSuperHeroes() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('superHeroCharacters')
          .get();

      _superHeroes = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      notifyListeners(); // Notify UI of changes
    } catch (e) {
      print('Failed to load superhero data: $e');
    }
  }

  String? _characterModelUrl; // URL for the 3D model
  bool _isModelLoading = false; // Loading state for 3D model

  String? get characterModelUrl => _characterModelUrl;

  bool get isModelLoading => _isModelLoading;

  // Fetch specific superhero's 3D model by character name
  Future<void> fetchCharacterModel(String characterName) async {
    try {
      _isModelLoading = true; // Start loading


      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('superHeroCharacters')
          .where('characterName', isEqualTo: characterName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first match (assuming name is unique)
        _characterModelUrl = querySnapshot.docs.first['character3dModal'];
      }

      _isModelLoading = false; // Stop loading
      notifyListeners();
    } catch (e) {
      _isModelLoading = false;
      print('Failed to load character model: $e');
      notifyListeners();
    }
  }

  // Initialize the provider and seed data if necessary
  SuperHeroCharacterDBProvider() {
    fetchSuperHeroes(); // Fetch the existing or newly seeded data
  }
}

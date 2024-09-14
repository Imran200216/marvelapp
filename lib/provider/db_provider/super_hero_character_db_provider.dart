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

  // Initialize the provider and seed data if necessary
  SuperHeroCharacterDBProvider() {
    fetchSuperHeroes(); // Fetch the existing or newly seeded data
  }
}

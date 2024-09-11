import 'package:flutter/material.dart';

class PasswordVisibilityProvider with ChangeNotifier {
  // Map to track visibility states for different fields
  final Map<String, bool> _visibilityStates = {};

  // Toggle visibility for a specific field
  void toggleVisibility(String fieldKey) {
    _visibilityStates[fieldKey] = !(_visibilityStates[fieldKey] ?? true);
    notifyListeners();
  }

  // Get visibility state for a specific field
  bool isObscure(String fieldKey) {
    return _visibilityStates[fieldKey] ?? true;
  }
}

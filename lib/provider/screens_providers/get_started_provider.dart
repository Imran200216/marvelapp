import 'package:flutter/material.dart';

class GetStartedProvider with ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  /// Go to the next page
  void nextPage() {
    if (currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage++;
      notifyListeners();
    }
  }

  /// Set the current page when manually swiped
  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }
}
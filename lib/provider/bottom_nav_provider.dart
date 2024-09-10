import 'package:flutter/widgets.dart';

class BottomNavProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void navigateToIndex(BuildContext context, int index) {
    setIndex(index);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

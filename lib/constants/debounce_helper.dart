import 'dart:async';

class DebounceHelper {
  Timer? _debounceTimer;

  bool isDebounced() {
    return _debounceTimer != null && _debounceTimer!.isActive;
  }

  void activateDebounce({required Duration duration}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, () {});
  }
}

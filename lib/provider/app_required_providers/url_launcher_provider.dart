import 'package:flutter/material.dart';
import 'package:marvelapp/constants/debounce_helper.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherProvider with ChangeNotifier {
  final DebounceHelper debounceHelper = DebounceHelper();

  /// Launch URL
  Future<void> launchUrlInBrowser(Uri url, BuildContext context) async {
    try {
      if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
        // Check if the debounce is active to prevent multiple toasts
        if (!debounceHelper.isDebounced()) {
          // Show the error toast
          ToastHelper.showErrorToast(
            context: context,
            message: "Cannot load the trailer. Please try again.",
          );
          // Activate debounce for a set duration
          debounceHelper.activateDebounce(duration: const Duration(seconds: 2));
        }
      }
    } catch (e) {
      // Check if the debounce is active to prevent multiple toasts
      if (!debounceHelper.isDebounced()) {
        // Show the success toast for exceptions
        ToastHelper.showSuccessToast(
          context: context,
          message: "Soon it will be updated!",
        );
        // Activate debounce for a set duration
        debounceHelper.activateDebounce(duration: const Duration(seconds: 2));
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:marvelapp/widgets/toast_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherProvider with ChangeNotifier {
  /// Launch URL
  Future<void> launchUrlInBrowser(Uri url, BuildContext context) async {
    try {
      if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
        // Show an error toast if the URL cannot be launched
        ToastHelper.showErrorToast(
          context: context,
          message: "Cannot load the trailer. Please try again.",
        );
      }
    } catch (e) {
      // Handle any unexpected exceptions
      ToastHelper.showErrorToast(
        context: context,
        message: "Something went wrong. Please try again.",
      );
    }
  }
}

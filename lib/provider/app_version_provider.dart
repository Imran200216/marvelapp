import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionProvider extends ChangeNotifier {
  String _appVersion = '';

  String get appVersion => _appVersion;

  AppVersionProvider() {
    _fetchAppVersion();
  }

  Future<void> _fetchAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    notifyListeners(); // Notify UI to update
  }
}

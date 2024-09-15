import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetCheckerProvider extends ChangeNotifier {
  bool isNetworkConnected = true;
  bool checkInternet = true;

  InternetCheckerProvider() {
    checkConnection();
    notifyListeners();
  }

  void checkConnection() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      bool isConnected = connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile);

      if (isConnected != isNetworkConnected) {
        isNetworkConnected = isConnected;
        checkInternet = isConnected;
        notifyListeners();
      }
    });
  }
}

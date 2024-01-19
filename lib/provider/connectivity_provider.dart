import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityResult _connectivityStatus = ConnectivityResult.other;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityProvider() {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  Future<void> _initConnectivity() async {
    try {
      _connectivityStatus = await _connectivity.checkConnectivity();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  ConnectivityResult get connectivity => _connectivityStatus;

  void _updateStatus(ConnectivityResult result) {
    _connectivityStatus = result;
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkListener extends ChangeNotifier {
  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;

  NetworkListener() {
    _init();
  }

  Future<void> _init() async {
    _hasInternet = await _checkInternetConnection();
    notifyListeners();

    const twoSec = Duration(seconds: 2);
    Timer.periodic(twoSec, (Timer t) async {
      bool currentStatus = await _checkInternetConnection();
      if (_hasInternet != currentStatus) {
        _hasInternet = currentStatus;
        notifyListeners();
      }
    });
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    try {
      final response = await http.get(Uri.parse('https://www.example.com/'));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }
}

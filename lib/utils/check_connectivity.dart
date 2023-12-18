import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class CheckConnectivity {
  Future<bool> check() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> goodConnection() async {
    try {
      http.Response response = await http.get(Uri.parse("https://www.google.com/"));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      return false;
    } catch (e) {
      return false;
    }
  }
}

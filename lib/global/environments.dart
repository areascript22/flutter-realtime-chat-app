import 'dart:io';

class Environments {
  static String apiUrl =
      Platform.isAndroid
          ? "httP://192.168.100.114:3000/api"
          : "http://localhost:3000/api";
  static String socketUrl =
      Platform.isAndroid ? "httP://10.0.2.2:3000" : "http://localhost:3000";
}

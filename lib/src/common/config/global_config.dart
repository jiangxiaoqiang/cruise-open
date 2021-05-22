import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

bool isLoggedIn = false;
String baseUrl = "";
String shareUrl = "";
String staticResourceUrl = "";
final storage = new FlutterSecureStorage();
final pageStorageBucket = PageStorageBucket();

enum ConfigType { DEV, PRO }

class GlobalConfig {


  static init(ConfigType configType) {
    switch (configType) {
      case ConfigType.DEV:
        baseUrl = "https://beta-api.poemhub.top";
        shareUrl = "https://beta-share.poemhub.top";
        staticResourceUrl = "https://beta-static.poemhub.top";
        break;
      case ConfigType.PRO:
        baseUrl = "https://api.poemhub.top";
        shareUrl = "https://share.poemhub.top";
        staticResourceUrl = "https://static.poemhub.top";
        break;
    }
  }
}

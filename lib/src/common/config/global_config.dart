import 'package:flutter_secure_storage/flutter_secure_storage.dart';

bool isLoggedIn = false;
String baseUrl = "";
String shareUrl = "";
final storage = new FlutterSecureStorage();

enum ConfigType { DEV, PRO }

class GlobalConfig {
  static init(ConfigType configType) {
    switch (configType) {
      case ConfigType.DEV:
        baseUrl = "https://beta-api.poemhub.top";
        shareUrl = "https://beta-share.poemhub.top";
        break;
      case ConfigType.PRO:
        baseUrl = "https://api.poemhub.top";
        shareUrl = "https://share.poemhub.top";
        break;
    }
  }
}

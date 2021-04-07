import 'package:flutter_secure_storage/flutter_secure_storage.dart';

bool isLoggedIn = false;
String baseUrl = "";
//const String baseUrl = "https://api.poemhub.top";
const String shareUrl = "http://175.24.235.247";
final storage = new FlutterSecureStorage();

enum ConfigType { DEV, PRO }

class GlobalConfig {
  static init(ConfigType configType) {
    switch (configType) {
      case ConfigType.DEV:
        baseUrl = "http://121.196.199.223:11014";
        break;
      case ConfigType.PRO:
        baseUrl = "http://121.196.199.223:11014";
        break;
    }
  }
}

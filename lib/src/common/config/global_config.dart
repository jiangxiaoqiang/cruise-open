import 'dart:collection';

import 'package:cruise/src/page/home/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

bool isLoggedIn = false;
String baseUrl = "";
String shareUrl = "";
String staticResourceUrl = "";
final storage = new FlutterSecureStorage();
final pageStorageBucket = PageStorageBucket();
final InAppPurchase inAppPurchase = InAppPurchase.instance;
final Map<String,HomeState> viewCache = HashMap();
enum ConfigType { DEV, PRO }

class GlobalConfig {
  static init(ConfigType configType) {
    switch (configType) {
      case ConfigType.DEV:
        baseUrl = GlobalConfiguration().get("baseUrl");
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

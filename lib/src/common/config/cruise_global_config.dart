import 'dart:async';

import 'package:cruise/src/widgets/app/app_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluwx/fluwx.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:wheel/wheel.dart' show AppLogHandler, GlobalConfig;
import 'package:wheel/wheel.dart';

final pageStorageBucket = PageStorageBucket();
final InAppPurchase inAppPurchase = InAppPurchase.instance;

class CruiseGlobalConfig {
  static void loadApp(ConfigType configType) async {
    GlobalConfig.init(configType);
    registerWxApi(appId: "wxd930ea5d5a228f5f", universalLink: "https://pay.poemhub.top/cruise/");
    void _handleError(Object obj, StackTrace stack) {
      AppLogHandler.logErrorStack("global error", obj, stack);
    }

    runZonedGuarded(() {
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        AppLogHandler.logFlutterErrorDetails(errorDetails);
      };
      runApp(AppPage());
    }, (Object error, StackTrace stackTrace) {
      _handleError(error, stackTrace);
    });
  }
}

import 'dart:async';
import 'dart:collection';

import 'package:cruise/src/page/home/state.dart';
import 'package:cruise/src/widgets/cruise_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel/wheel.dart' show AppLogHandler;

import '../theme.dart';
import '../view_manager.dart';

bool isLoggedIn = false;
String baseUrl = "";
String staticResourceUrl = "";
final storage = new FlutterSecureStorage();
final pageStorageBucket = PageStorageBucket();
final InAppPurchase inAppPurchase = InAppPurchase.instance;
final Map<String,HomeState> viewCache = HashMap();

class CruiseGlobalConfig {

  static void loadApp() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? themeName = pref.getString('theme');
    final theme = ThemeManager.fromThemeName(themeName);
    String? viewName = pref.getString('view');
    final view = ViewManager.fromViewName(viewName);
    print(GlobalConfiguration().get("baseUrl"));

    void _handleError(Object obj, StackTrace stack) {
      AppLogHandler.logErrorStack("global error",obj, stack);
    }

    runZonedGuarded((){
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        AppLogHandler.logFlutterErrorDetails(errorDetails);
      };
      runApp(
        CruiseApp(
            theme: theme,
            view: view
        ),
      );
    },(Object error,StackTrace stackTrace){
      _handleError(error,stackTrace);
    });
  }
}





import 'dart:async';
import 'dart:collection';

import 'package:cruise/src/page/home/state.dart';
import 'package:cruise/src/widgets/app/app.dart';
import 'package:cruise/src/widgets/app/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:wheel/wheel.dart' show AppLogHandler;

String baseUrl = "";
final storage = new FlutterSecureStorage();
final pageStorageBucket = PageStorageBucket();
final InAppPurchase inAppPurchase = InAppPurchase.instance;
final Map<String,HomeState> viewCache = HashMap();

class CruiseGlobalConfig {
  static void loadApp() async{
    void _handleError(Object obj, StackTrace stack) {
      AppLogHandler.logErrorStack("global error",obj, stack);
    }
    runZonedGuarded((){
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        AppLogHandler.logFlutterErrorDetails(errorDetails);
      };
      runApp(
          //AppPage().buildPage({'name': "app_page"})
          createApp()
      );
    },(Object error,StackTrace stackTrace){
      _handleError(error,stackTrace);
    });
  }
}





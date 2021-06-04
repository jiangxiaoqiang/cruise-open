import 'dart:async';

import 'package:cruise/src/common/theme.dart';
import 'package:cruise/src/common/utils/common_utils.dart';
import 'package:cruise/src/common/view_manager.dart';
import 'package:cruise/src/widgets/cruise_app.dart';
import 'package:flutter/material.dart';
import 'package:wheel/wheel.dart' show AppLogHandler;

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  CommonUtils.initialApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? themeName = pref.getString('theme');
  final theme = ThemeManager.fromThemeName(themeName);
  String? viewName = pref.getString('view');
  final view = ViewManager.fromViewName(viewName);

  void _handleError(Object obj, StackTrace stack) {
    AppLogHandler.logErrorStack(obj.toString(),stack);
  }

  runZonedGuarded((){
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      AppLogHandler.logFlutterErrorDetails(errorDetails);
    };
    runApp(
      CruiseApp(
        theme: theme,
        view: view,
      ),
    );
  },(Object error,StackTrace stackTrace){
    _handleError(error,stackTrace);
  });
}

// @dart=2.12
import 'package:cruise/src/common/config/global_config.dart';
import 'package:cruise/src/common/history.dart';
import 'package:cruise/src/common/theme.dart';
import 'package:cruise/src/common/utils/custom_en.dart';
import 'package:cruise/src/common/view_manager.dart';
import 'package:cruise/src/widgets/cruise_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  GlobalConfig.init(ConfigType.PRO);
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase.
  // https://firebase.flutter.dev/docs/crashlytics/usage/
  await Firebase.initializeApp();
  timeago.setLocaleMessages('en', CustomEn());
  await HistoryManager.init();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? themeName = pref.getString('theme');
  final theme = ThemeManager.fromThemeName(themeName);
  String? viewName = pref.getString('view');
  final view = ViewManager.fromViewName(viewName);
  FirebaseCrashlytics.instance.crash();
  runApp(
    CruiseApp(
      theme: theme,
      view: view,
    ),
  );
}

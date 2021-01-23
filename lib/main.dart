import 'package:Cruise/src/common/history.dart';
import 'package:Cruise/src/common/theme.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:Cruise/src/widgets/CruiseApp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomEn extends timeago.EnMessages {
  @override
  String suffixAgo() => '';
  String minutes(int minutes) => '${minutes}m';
  String hours(int hours) => '${hours}h';
  String days(int days) => '${days}d';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('en', CustomEn());
  await HistoryManager.init();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String themeName = pref.getString('theme');
  final theme = ThemeManager.fromThemeName(themeName);
  String viewName = pref.getString('view');
  final view = ViewManager.fromViewName(viewName);
  runApp(
    CruiseApp(
      theme: theme,
      view: view,
    ),
  );
}

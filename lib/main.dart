import 'package:Cruise/src/widgets/CruiseApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Cruise/src/common/history.dart';
import 'package:Cruise/src/common/theme.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomEn extends timeago.EnMessages {
  @override
  String suffixAgo() => '';

  String minutes(int minutes) => '${minutes}m';

  String hours(int hours) => '${hours}h';

  String days(int days) => '${days}d';
}

const String _exampleDsn =
    'https://de8b8babf1d64e729b7798b2b761fda5@o485171.ingest.sentry.io/5539934';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('en', CustomEn());
  await HistoryManager.init();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String themeName = pref.getString('theme');
  final theme = ThemeManager.fromThemeName(themeName);
  String viewName = pref.getString('view');
  final view = ViewManager.fromViewName(viewName);
  //registerWxApi(appId: "your app id", doOnAndroid: true, doOnIOS: true,universalLink:"https://example.com");
  await SentryFlutter.init(
    (options) => options.dsn = _exampleDsn,
    appRunner: () => {
      runApp(ProviderScope(
        child: CruiseApp(
          theme: theme,
          view: view,
        ),
      ))
    },
  );
}

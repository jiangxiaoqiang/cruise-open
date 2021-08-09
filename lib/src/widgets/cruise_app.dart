import 'package:cruise/src/common/theme.dart';
import 'package:cruise/src/common/utils/common_utils.dart';
import 'package:cruise/src/common/utils/navigation_service.dart';
import 'package:cruise/src/common/view_manager.dart';
import 'package:cruise/src/page/login.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux/src/redux_component/page.dart' as fishPage;
import 'package:flutter/foundation.dart';
import 'package:cruise/src/common/config/cruise_global_config.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CruiseApp extends HookWidget {
  CruiseApp({required this.theme, required this.view});

  final ThemeData theme;
  final ViewType view;

  @override
  Widget build(BuildContext context) {

    final currentTheme = ThemeManager.fromThemeName("lightTheme");
    final AbstractRoutes routes = CommonUtils.buildRoute();
    bool showDebugInfo = false;

    return MaterialApp(
      title: 'Cruise',
      theme: currentTheme,
      navigatorKey: NavigationService.instance.navigationKey,
      checkerboardOffscreenLayers: showDebugInfo,
      // saveLayer 方法使用情况的检查,使用了saveLayer的图像会显示为棋盘格式并随着页面刷新而闪烁
      checkerboardRasterCacheImages: showDebugInfo,
      // 检查缓存图像,做了缓存的静态图像图片在刷新页面使不会改变棋盘格的颜色；如果棋盘格颜色变了，说明被重新缓存，这是我们要避免的
      showPerformanceOverlay: showDebugInfo,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        // TODO: uncomment the line below after codegen
        // AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('ar', ''), // Arabic, no country code
        const Locale.fromSubtags(languageCode: 'zh'), // Chinese *See Advanced Locales below*
        // ... other locales the app supports
      ],
      routes: {
        "login": (BuildContext context) => LoginPage(),
      },
      home:routes.buildPage('home', {"selectIndex":0}),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<Object>(builder: (BuildContext context) {
          return routes.buildPage(settings.name!, settings.arguments);
        });
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:wheel/wheel.dart';

import '../../page/home/home.dart';
import '../../page/login.dart';
import 'global_controller.dart';

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ThemeManager.fromThemeName("lightTheme");

    Widget buildHomePage() {
      return new HomeDefault();
    }

    return GetBuilder<GlobalController>(
        init: GlobalController(),
        builder: (controller) {
          return GetMaterialApp(
            title: 'Cruise',
            theme: currentTheme,
            navigatorKey: NavigationService.instance.navigationKey,
            checkerboardOffscreenLayers: controller.showDebug,
            // saveLayer 方法使用情况的检查,使用了saveLayer的图像会显示为棋盘格式并随着页面刷新而闪烁
            checkerboardRasterCacheImages: controller.showDebug,
            // 检查缓存图像,做了缓存的静态图像图片在刷新页面使不会改变棋盘格的颜色；如果棋盘格颜色变了，说明被重新缓存，这是我们要避免的
            showPerformanceOverlay: controller.showDebug,
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              // TODO: uncomment the line below after codegen
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

            home: buildHomePage(),
            onGenerateRoute: (RouteSettings settings) {},
          );
        });
  }
}

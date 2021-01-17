import 'package:Cruise/src/page/home/page.dart';
import 'package:Cruise/src/page/user/login/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:Cruise/src/common/theme.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:fish_redux/src/redux_component/page.dart' as fishPage;

class CruiseApp extends HookWidget {
  CruiseApp({@required this.theme, @required this.view});

  final ThemeData theme;
  final ViewType view;


  @override
  Widget build(BuildContext context) {
    final currentTheme = ThemeManager.fromThemeName("lightTheme");

    final AbstractRoutes routes = PageRoutes(
      pages: <String, fishPage.Page<Object, dynamic>>{
        'entrance_page': LoginPage(),
        'home': HomePage()
      },
    );

    return MaterialApp(
        title: 'Cruise',
        theme: currentTheme,
        localizationsDelegates: [

        ],
        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale.fromSubtags(languageCode: 'zh'), // Chinese *See Advanced Locales below*
        ],
        //home: HomeNew(),
        home: routes.buildPage('home', null),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute<Object>(builder: (BuildContext context) {
            return routes.buildPage(settings.name, settings.arguments);
          });
        });
  }
}

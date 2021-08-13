import 'package:cruise/src/common/store/state.dart';
import 'package:cruise/src/common/store/store.dart';
import 'package:cruise/src/page/home/page.dart';
import 'package:cruise/src/page/user/settings/main/page.dart';
import 'package:cruise/src/widgets/app/page.dart';
import 'package:fish_redux/fish_redux.dart' as fishPage;
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget createApp(){
  final AbstractRoutes routes = PageRoutes(
      pages:<String,fishPage.Page<Object,dynamic>>{
        'home_page': HomePage(), 'app_page': AppPage(), 'main_page': MainPage()
      } ,
    visitor: (String path,fishPage.Page<Object, dynamic> page){
        if(page.isTypeof<GlobalBaseState>()){
          page.connectExtraStore<GlobalState>(GlobalStore.store, (Object pageState,GlobalState appState){
            final GlobalBaseState p = pageState as GlobalBaseState;
            if(p.showDebug !=appState.showDebug){
              if(pageState is Cloneable){
                // final Object newState = pageState.clone();
                pageState.showDebug = true;
                return pageState;
              }
            }
            return pageState;
          });
        }
    },
  );

  return MaterialApp(
    title: 'FishDemo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
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
    home: routes.buildPage('home_page', {"selectIndex": 0}),
    onGenerateRoute: (RouteSettings settings){
      return MaterialPageRoute<Object>(builder: (BuildContext context){
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
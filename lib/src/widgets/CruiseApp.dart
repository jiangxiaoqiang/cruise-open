import 'package:Cruise/src/home/home_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:Cruise/src/common/theme.dart';
import 'package:Cruise/src/common/view_manager.dart';

class CruiseApp extends HookWidget {
  const CruiseApp({@required this.theme, @required this.view});

  final ThemeData theme;
  final ViewType view;

  @override
  Widget build(BuildContext context) {
    final themeManager = useProvider(themeProvider);
    final viewManager = useProvider(viewProvider);
    useMemoized(() {
      // TODO: Right now this triggers a rebuild, so unfortunately you'll see a flash of default theme.
      themeManager.setTheme(theme);
      viewManager.setView(view);
    });

    final currentTheme = useProvider(themeProvider.state);
    return MaterialApp(
      title: 'Cruise',
      theme: currentTheme,
      routes: {
        "home": (context) => HomeNew(),
      },
      home: HomeNew(),
    );
  }
}

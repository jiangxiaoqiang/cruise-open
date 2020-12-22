import 'dart:js';

import 'package:Cruise/src/common/theme.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'action.dart';
import 'state.dart';

final currentView = useProvider(viewProvider.state);
final ViewManager viewManager = useProvider(viewProvider);
final currentTheme = useProvider(themeProvider.state);
final ThemeManager themeManager = useProvider(themeProvider);

Widget buildView(
    CruiseSettingState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: SafeArea(
      child: ListView(
        children: [
          ListTile(
            title: Text("主题"),
            leading: Icon(Feather.moon),
            onTap: () => {
              showDialog(builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) => SimpleDialog(
                    title: Text("Theme"),
                    children: [
                      RadioListTile(
                        title: const Text('Light'),
                        value: lightTheme,
                        groupValue: currentTheme,
                        onChanged: (value) {
                          themeManager.setTheme(value);
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile(
                        title: const Text('Dark'),
                        value: darkTheme,
                        groupValue: currentTheme,
                        onChanged: (value) {
                          themeManager.setTheme(value);
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile(
                        title: const Text('True Black'),
                        value: trueBlackTheme,
                        groupValue: currentTheme,
                        onChanged: (value) {
                          themeManager.setTheme(value);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              })
            },
          )
        ],
      ),
    ),
  );
}

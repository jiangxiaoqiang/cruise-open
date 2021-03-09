import 'package:Cruise/src/common/auth.dart';
import 'package:Cruise/src/common/theme.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/page/login.dart';
import 'package:Cruise/src/page/profile.dart';
import 'package:Cruise/src/page/user/Fav.dart';
import 'package:Cruise/src/page/user/about.dart';
import 'package:Cruise/src/page/user/feedback_page.dart';
import 'package:Cruise/src/page/user/settings/custom_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CruiseSettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final currentView = ViewManager.fromViewName("itemCard");
    final ViewManager viewManager = new ViewManager();
    final currentTheme = ThemeManager.fromThemeName("lightTheme");
    final ThemeManager themeManager = new ThemeManager();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text("主题"),
              leading: Icon(Feather.moon),
              onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) => SimpleDialog(
                      title: Text("Theme"),
                      children: [
                        RadioListTile(
                          title: const Text('Light'),
                          value: lightTheme,
                          groupValue: currentTheme,
                          onChanged: (value) {
                            themeManager.setTheme(value as ThemeData);
                            Navigator.pop(context);
                          },
                        ),
                        RadioListTile(
                          title: const Text('Dark'),
                          value: darkTheme,
                          groupValue: currentTheme,
                          onChanged: (value) {
                            themeManager.setTheme(value as ThemeData);
                            Navigator.pop(context);
                          },
                        ),
                        RadioListTile(
                          title: const Text('True Black'),
                          value: trueBlackTheme,
                          groupValue: currentTheme,
                          onChanged: (value) {
                            themeManager.setTheme(value as ThemeData);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: Text("视图"),
              leading: Icon(Feather.grid),
              onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text("View"),
                    children: <Widget>[
                      RadioListTile(
                        title: const Text('Card'),
                        value: ViewType.itemCard,
                        groupValue: currentView,
                        onChanged: (value) {
                          viewManager.setView(value as ViewType);
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile(
                        title: const Text('Compact'),
                        value: ViewType.compactTile,
                        groupValue: currentView,
                        onChanged: (value) {
                          viewManager.setView(value as ViewType);
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile(
                        title: const Text('Tile'),
                        value: ViewType.itemTile,
                        groupValue: currentView,
                        onChanged: (value) {
                          viewManager.setView(value as ViewType);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Feather.user),
              title: Text("我的"),
              onTap: () async {
                Widget page;
                bool isLoggedIn = await Auth.isLoggedIn();
                if (!isLoggedIn) {
                  page = LoginPage();
                  //page = BottomNavigationDemo(type: BottomNavigationDemoType.withLabels);
                } else {
                  var username = await Auth.currentUser();

                  page = ProfilePage(username: "dolphin", isMe: true);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
            ),
            ListTile(
              leading: Icon(Feather.bookmark),
              title: Text("收藏"),
              onTap: () async {
                Widget page = Fav(currentStoriesType: StoriesType.favStories);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
            ),
            ListTile(
              leading: Icon(Feather.mail),
              title: Text("问题反馈"),
              onTap: () async {
                Widget page = FeedbackPage();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
            ),
            ListTile(
              leading: Icon(Feather.award),
              title: Text("关于Cruise"),
              onTap: () async {
                Widget page = About();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
            ),
            ListTile(
              leading: Icon(Feather.settings),
              title: Text("设置"),
              onTap: () async {
                Widget page = CustomSetting();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

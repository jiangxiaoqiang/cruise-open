import 'package:Cruise/src/common/auth.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/page/home/components/homelist_component/action.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../login.dart';
import '../../Fav.dart';
import '../custom_setting.dart';
import 'state.dart';

Widget buildView(CruiseSettingState state, Dispatch dispatch, ViewService viewService) {
  BuildContext context = viewService.context;

  return Scaffold(
    body: SafeArea(
      child: ListView(
        children: [
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
                      onChanged: (value) {
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile(
                      title: const Text('Compact'),
                      value: ViewType.compactTile,
                      onChanged: (value) {
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile(
                      title: const Text('Tile'),
                      value: ViewType.itemTile,
                      onChanged: (value) {
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

                //page = ProfilePage(username: "dolphin", isMe: true);
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
            leading: Icon(Feather.archive),
            title: Text("发现"),
            onTap: () async {
              dispatch(HomeListActionCreator.onChangeStoriesType(StoriesType.originalStories));
              return null;
            },
          ),
          ListTile(
            leading: Icon(Feather.mail),
            title: Text("问题反馈"),
            onTap: () async {
              /*Widget page = FeedbackPage();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );*/
            },
          ),
          ListTile(
            leading: Icon(Feather.award),
            title: Text("关于Cruise"),
            onTap: () async {
              /*Widget page = About();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );*/
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

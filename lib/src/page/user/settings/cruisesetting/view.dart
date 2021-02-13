import 'package:Cruise/src/common/auth.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:Cruise/src/page/user/discover/page.dart';
import 'package:Cruise/src/page/user/fav/page.dart';
import 'package:Cruise/src/page/user/feedback/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../login.dart';
import '../custom_setting.dart';
import 'state.dart';

Widget buildView(CruiseSettingState state, Dispatch dispatch, ViewService viewService) {
  BuildContext context = viewService.context;
  double screenWidth = MediaQuery.of(context).size.width;

  return Scaffold(
    backgroundColor: const Color(0xFFEFEFEF),
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
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.white,
                      child: ListTile(
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
                      )))),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ClipRRect(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Feather.bookmark),
                            title: Text("收藏"),
                            onTap: () async {
                              var data = {'name': "fav"};
                              Widget page = FavArticlePage().buildPage(data);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => page),
                              );
                            },
                          ))))),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Feather.archive),
                        title: Text("发现"),
                        onTap: () async {
                          var data = {'name': "originalstories"};
                          Widget page = DiscoverPage().buildPage(data);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => page),
                          );
                        },
                      )))),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Feather.mail),
                        title: Text("问题反馈"),
                        onTap: () async {
                          var data = {'name': "feedback"};
                          Widget feedback = FeedbackPage().buildPage(data);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => feedback),
                          );
                        },
                      )))),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Feather.award),
                        title: Text("关于Cruise"),
                        onTap: () async {
                          /*Widget page = About();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => page),
                          );*/
                        },
                      )))),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.white,
                      //margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ListTile(
                        leading: Icon(Feather.settings),
                        title: Text("设置"),
                        onTap: () async {
                          Widget page = CustomSetting();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => page),
                          );
                        },
                      ))))
        ],
      ),
    ),
  );
}

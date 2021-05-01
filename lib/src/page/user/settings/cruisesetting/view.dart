import 'package:cruise/src/common/auth.dart';
import 'package:cruise/src/page/user/discover/page.dart';
import 'package:cruise/src/page/user/fav/page.dart';
import 'package:cruise/src/page/user/feedback/page.dart';
import 'package:cruise/src/page/user/settings/about/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cruise/src/common/cruise_user.dart';

import '../../../login.dart';
import '../../../profile.dart';
import 'state.dart';

Widget buildView(CruiseSettingState state, Dispatch dispatch, ViewService viewService) {
  BuildContext context = viewService.context;

  return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 55, 0, 0),
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Feather.user),
                            title: Text("登录"),
                            onTap: () async {
                              Widget page;
                              bool isLoggedIn = await Auth.isLoggedIn();
                              if (isLoggedIn) {
                                page = LoginPage();
                                //page = BottomNavigationDemo(type: BottomNavigationDemoType.withLabels);
                              } else {
                                //var username = await Auth.currentUser();
                                CruiseUser usr = new CruiseUser(about: "about",
                                    created: 1,
                                    delay: 1,
                                    id: "",
                                    karma: 1);
                                page = ProfilePage(
                                    username: "dolphin",
                                    isMe: true,
                                    user: usr
                                );
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
                            title: Text("关于cruise"),
                            onTap: () async {
                              var data = {'name': "aboutPage"};
                              Widget aboutPage = AboutPage().buildPage(data);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => aboutPage),
                              );
                            },
                          )))),
              /*Padding(
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
                          ))))*/
            ],
          ),
        ),
      ));
}

import 'package:cruise/src/page/user/settings/about/privicy/page.dart';
import 'package:cruise/src/page/user/settings/about/version/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'contract/page.dart';
import 'state.dart';

Widget buildView(aboutState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: const Color(0xFFEFEFEF),
    body: Form(
      child: ListView(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Feather.award),
                        title: Text("关于cruise"),
                        onTap: () {
                          var data = {'name': "contractPage"};
                          Widget contractPage = ContractPage().buildPage(data);
                          Navigator.push(
                            viewService.context,
                            MaterialPageRoute(builder: (context) => contractPage),
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
                        title: Text("隐私政策"),
                        onTap: () {
                          var data = {'name': "privacyPage"};
                          Widget privacyPage = PrivacyPage().buildPage(data);
                          Navigator.push(
                            viewService.context,
                            MaterialPageRoute(builder: (context) => privacyPage),
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
                        title: Text("版本信息"),
                        onTap: () {
                          var data = {'name': "versionPage"};
                          Widget versionPage = VersionPage().buildPage(data);
                          Navigator.push(
                            viewService.context,
                            MaterialPageRoute(builder: (context) => versionPage),
                          );
                        },
                      )))),
        ],
      ),
    ),
  );
}

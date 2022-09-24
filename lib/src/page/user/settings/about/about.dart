import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          leading: Icon(EvaIcons.award),
                          title: Text("关于cruise"),
                          onTap: () {
                            var data = {'name': "contractPage"};
                          },
                        )))),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: Icon(EvaIcons.award),
                          title: Text("隐私政策"),
                          onTap: () {
                            var data = {'name': "privacyPage"};
                          },
                        )))),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: Icon(EvaIcons.award),
                          title: Text("版本信息"),
                          onTap: () {
                            var data = {'name': "versionPage"};
                          },
                        )))),
          ],
        ),
      ),
    );
  }
}

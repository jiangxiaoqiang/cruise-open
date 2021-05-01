import 'package:cruise/src/common/auth.dart';
import 'package:cruise/src/common/cruise_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfilePage extends HookWidget {
  ProfilePage({required this.username, this.isMe = false, required this.user});

  final String username;
  final bool isMe;
  final CruiseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text(
          "个人信息",
        ),
        actions: [
          if (isMe)
            IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("登出"),
                      content: Text("确定过要登出么?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "取消",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.caption!.color,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Auth.logout();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "登出",
                            style: TextStyle(color: Colors.red[400]),
                          ),
                        ),
                      ],
                    );
                  }),
              icon: Icon(
                Feather.log_out,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child:Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text("用户名"),
                          subtitle: Text('+8615683761628'),
                          onTap: () async {

                          },
                        ))))),
            SliverToBoxAdapter(
                child:Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            color: Colors.white,
                            child: ListTile(
                              title: Text("注册时间"),
                              subtitle: Text('2020-02-03'),
                              onTap: () async {

                              },
                            ))))),
          ],
        ),
      ),
    );
  }
}

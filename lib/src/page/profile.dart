import 'package:cruise/src/common/cruise_user.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:wheel/wheel.dart' show Auth, NavigationService;
import 'package:cruise/src/common/config/cruise_global_constant.dart' as CruiseGlobalConstant;

class ProfilePage extends HookWidget {
  ProfilePage({this.isMe = false, required this.user});

  final bool isMe;
  final CruiseUser user;

  @override
  Widget build(BuildContext context) {
    String timestamp = user.registerTime == null ? "0" : user.registerTime!;
    var format = new DateFormat("yMd");
    var dateString = timestamp == "0" ? "--" : format.format(new DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)));

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Map<String,Object> args = new Map();
              args.putIfAbsent("selectIndex", () => 3);
              args.putIfAbsent("storiesType", () => StoriesType.profile);
              args.putIfAbsent("autoTriggerNav", () => true);
              NavigationService.instance.navigateToReplacementWithParam(CruiseGlobalConstant.HOME_PAGE_NAME,args);
            }),
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
                      content: Text("确定要登出么?"),
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
                            Auth.logout();
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
                EvaIcons.logOut,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            color: Colors.white,
                            child: ListTile(
                              title: Text("用户名"),
                              subtitle: Text(user.phone == null ? "--" : user.phone!),
                              onTap: () async {},
                            ))))),
            SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            color: Colors.white,
                            child: ListTile(
                              title: Text("注册时间"),
                              subtitle: Text(dateString),
                              onTap: () async {},
                            ))))),
          ],
        ),
      ),
    );
  }
}

import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/page/user/profile/profile_controller.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wheel/wheel.dart' show Auth;
import 'package:wheel/wheel.dart';

import '../../home/home.dart';
import '../../home/home_controller.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          String timestamp = controller.user.registerTime == null ? "0" : controller.user.registerTime!;
          var format = new DateFormat("yMd");
          var dateString = timestamp == "0" ? "--" : format.format(new DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)));

          return Scaffold(
            backgroundColor: const Color(0xFFEFEFEF),
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    final HomeController homeController = Get.put(HomeController());
                    homeController.updateNav(3, StoriesType.profile);
                    Get.to(() => new HomeDefault());
                  }),
              title: Text(
                "个人信息",
              ),
              actions: [
                if (controller.isMe.value)
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
                                    subtitle: Text(controller.user.phone == null ? "--" : controller.user.phone!),
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
        });
  }
}

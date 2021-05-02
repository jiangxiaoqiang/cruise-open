import 'package:cruise/src/common/utils/common_utils.dart';
import 'package:cruise/src/page/login.dart';
import 'package:cruise/src/page/profile.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

class NavUtil {

  static Future<void> navProfile(BuildContext context) async {
    var user = await Auth.currentUser();
    Widget page = ProfilePage(isMe: true, user: user);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<void> navLogin(BuildContext context,ViewService viewService) async {
    Widget page = LoginPage(viewService: viewService,);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<void> navHome(BuildContext context,ViewService viewService) async {
    final AbstractRoutes routes = CommonUtils.buildRoute();
    Widget page = routes.buildPage("home", null);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

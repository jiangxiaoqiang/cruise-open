import 'package:cruise/src/common/cruise_user.dart';
import 'package:cruise/src/common/utils/common_utils.dart';
import 'package:cruise/src/page/login.dart';
import 'package:cruise/src/page/profile.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wheel/wheel.dart' show Auth;

class NavUtil {

  static Future<void> navProfile(BuildContext context) async {
    var user = await Auth.currentUser();
    CruiseUser cruiseUser = new CruiseUser(phone: user.phone,registerTime: user.registerTime);
    Widget page = ProfilePage(isMe: true, user: cruiseUser);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<void> navLogin(BuildContext context) async {
    Widget page = LoginPage();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<void> navHome(BuildContext context) async {
    final AbstractRoutes routes = CommonUtils.buildRoute();
    Widget page = routes.buildPage("home", null);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

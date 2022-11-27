import 'package:cruise/src/common/cruise_user.dart';
import 'package:cruise/src/page/login.dart';
import 'package:cruise/src/page/user/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheel/wheel.dart' show Auth;

import '../../page/user/profile/profile_controller.dart';

class NavUtil {
  static Future<void> navProfile(BuildContext context) async {
    var user = await Auth.currentUser();
    CruiseUser cruiseUser = new CruiseUser(phone: user.phone, registerTime: user.registerTime);
    final ProfileController homeController = Get.put(ProfileController());
    homeController.isMe.value = true;
    homeController.user = cruiseUser;
    Get.to(() => ProfilePage());
  }

  static Future<void> navLogin(BuildContext context) async {
    Widget page = LoginPage();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

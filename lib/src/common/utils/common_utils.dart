import 'dart:async';
import 'dart:io';

import 'package:cruise/src/common/config/global_config.dart';
import 'package:cruise/src/component/channel_compact_tile.dart';
import 'package:cruise/src/component/channel_item_card.dart';
import 'package:cruise/src/component/channel_item_tile.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/page/home/page.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux/src/redux_component/page.dart' as fishPage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../history.dart';
import '../view_manager.dart';
import 'custom_en.dart';

class CommonUtils {
  static void initialApp() {
    GlobalConfig.init(ConfigType.PRO);
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize Firebase, collection app crash report
    // https://firebase.flutter.dev/docs/crashlytics/usage/
    Firebase.initializeApp();
    timeago.setLocaleMessages('en', CustomEn());
    HistoryManager.init();

    // in app purchase initial
    if (defaultTargetPlatform == TargetPlatform.android) {
      InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
    }
  }

  static AbstractRoutes buildRoute() {
    final AbstractRoutes routes = PageRoutes(
      pages: <String, fishPage.Page<Object, dynamic>>{'home': HomePage()},
    );
    return routes;
  }

  static Widget getChannelViewType(ViewType type, Channel item) {
    switch (type) {
      case ViewType.compactTile:
        return ChannelCompactTile(item: item);
        break;
      case ViewType.itemCard:
        return ChannelItemCard(item: item);
        break;
      case ViewType.itemTile:
        return ChannelItemTile(item: item);
        break;
      default:
        return ChannelItemCard(item: item);
        break;
    }
  }

  static void launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<List<String>> getDeviceDetails() async {
    String deviceName = "";
    String deviceVersion = "";
    String identifier = "";
    String deviceType = "-1";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
        deviceType = "2";
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
        deviceType = "1";
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return [deviceName, deviceType, identifier];
  }
}

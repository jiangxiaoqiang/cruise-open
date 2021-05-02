import 'package:cruise/src/component/channel_compact_tile.dart';
import 'package:cruise/src/component/channel_item_card.dart';
import 'package:cruise/src/component/channel_item_tile.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/page/home/page.dart';
import 'package:fish_redux/src/redux_component/page.dart' as fishPage;
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view_manager.dart';

class CommonUtils{

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

}



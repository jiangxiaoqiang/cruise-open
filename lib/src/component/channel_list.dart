import 'package:Cruise/src/component/channel_item_tile.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/page/channel_page.dart';
import 'package:Cruise/src/page/channels_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:Cruise/src/component/loading_item.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'channel_compact_tile.dart';
import 'channel_item_card.dart';

class ChannelList extends HookWidget {
  const ChannelList({
    Key key,
    @required this.ids,
  }) : super(key: key);

  final List<int> ids;
  
  @override
  Widget build(BuildContext context) {

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
        },
        childCount: ids.length,
      ),
    );
  }

}

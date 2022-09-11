import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/page/channel/channeldetail_component/channel_detail.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fish_redux/fish_redux.dart' as FGet;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../channel_page.dart';
import '../channeldetail_component/channel_detail_controller.dart';
import 'state.dart';

Widget buildView(ChannelPgState state, FGet.Dispatch dispatch, FGet.ViewService viewService) {
  Channel item = state.channel;
  BuildContext context = viewService.context;

  Widget navChannelDetail(Channel channel) {
    final ChannelDetailController articlePgController = Get.put(ChannelDetailController());
    articlePgController.channel = item;
    return new ChannelDetail();
  }

  return Scaffold(
    appBar: AppBar(
      title: Text('Cruise'),
      brightness: Brightness.light, // or use Brightness.dark
      actions: [
        if (item.parent != null)
          IconButton(
            icon: Icon(EvaIcons.cornerLeftUp),
            onPressed: () async {
              Channel parent = (await Repo.fetchChannelItem(item.parent))!;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChannelPage(item: parent)),
              );
            },
          ),
      ],
    ),
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: navChannelDetail(item)),
      ],
    ),
  );
}

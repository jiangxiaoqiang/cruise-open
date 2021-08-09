import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../channel_page.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(ChannelPgState state, Dispatch dispatch, ViewService viewService) {
  Channel item = state.channel;
  BuildContext context = viewService.context;

  Widget navChannelDetail(Channel channel) {
    if (state.channelDetailState.channel == null) {
      dispatch(ChannelPgActionCreator.onSetDetailChannel(channel));
    }
    return viewService.buildComponent("channeldetail");
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

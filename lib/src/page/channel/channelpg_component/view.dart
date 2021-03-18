import 'package:Cruise/src/common/repo.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
            icon: Icon(Feather.corner_left_up),
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

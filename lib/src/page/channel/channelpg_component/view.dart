import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/component/channel_information.dart';
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

  return Scaffold(
    appBar: AppBar(
      title: Text('Cruise'),
      actions: [
        if (item.parent != null)
          IconButton(
            icon: Icon(Feather.corner_left_up),
            onPressed: () async {
              Channel parent = await Repo.fetchChannelItem(item.parent);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChannelPage(item: parent)),
              );
            },
          ),
      ],
    ),
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: ChannelInformation(item: item)),
      ],
    ),
  );
}

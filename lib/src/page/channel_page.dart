import 'package:Cruise/src/component/channel_information.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Cruise/src/common/Repo.dart';

class ChannelPage extends HookWidget {
  const ChannelPage({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Channel item;

  @override
  Widget build(BuildContext context) {
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
}

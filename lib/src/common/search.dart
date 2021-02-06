import 'package:Cruise/src/common/view_manager.dart';
import 'package:Cruise/src/component/channel_compact_tile.dart';
import 'package:Cruise/src/component/channel_item_card.dart';
import 'package:Cruise/src/component/channel_item_tile.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/request/channel/channel_request.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'channel_action.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  _getChannelViewType(ViewType type, Channel item) {
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

  Widget buildChannel(Channel channel) {
    //dispatch(ChannelListActionCreator.onSetDetailChannel(channel));
    //return viewService.buildComponent("articlepg");
  }

  final currentView = ViewManager.fromViewName("itemCard");

  @override
  Widget buildResults(BuildContext context) {
    var channelRequest = new ChannelRequest();
    channelRequest.name = query;
    channelRequest.pageNum = 1;
    channelRequest.pageSize = 10;

    return FutureBuilder(
        future: ChannelAction.searchChannel(channelRequest),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Channel> post = snapshot.data;
            if (post != null) {
              return CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Slidable(
                      actionPane: SlidableScrollActionPane(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: OpenContainer(
                            tappable: true,
                            closedElevation: 0,
                            closedColor: Theme.of(context).scaffoldBackgroundColor,
                            openColor: Theme.of(context).scaffoldBackgroundColor,
                            transitionDuration: Duration(milliseconds: 500),
                            closedBuilder: (BuildContext c, VoidCallback action) => _getChannelViewType(currentView, post[index]),
                            openBuilder: (BuildContext c, VoidCallback action) => buildChannel(post[index])),
                      ),
                    );
                  }, childCount: post.length))
                ],
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(title: Text('Suggest 01')),
        ListTile(title: Text('Suggest 02')),
        ListTile(title: Text('Suggest 03')),
        ListTile(title: Text('Suggest 04')),
        ListTile(title: Text('Suggest 05')),
      ],
    );
  }
}

import 'package:animations/animations.dart';
import 'package:cruise/src/common/utils/cruise_common_utils.dart';
import 'package:cruise/src/common/view_manager.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/channel_suggestion.dart';
import 'package:cruise/src/models/request/channel/channel_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../page/channel/channelpg_component/channel_pg.dart';
import '../page/channel/channelpg_component/channel_pg_controller.dart';
import 'channel_action.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() {}

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

  Widget buildChannel(Channel channel, BuildContext context) {
    final ChannelPgController articlePgController = Get.put(ChannelPgController());
    articlePgController.channelId.value = channel.id;
    Get.to(ChannelPg());
    return Container();
  }

  final currentView = ViewManager.fromViewName("itemCard");

  Widget buildResultsComponent(List<Channel> channels, BuildContext context) {
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
                  closedBuilder: (BuildContext c, VoidCallback action) =>
                      CruiseCommonUtils.getChannelViewType(currentView, channels[index]),
                  openBuilder: (BuildContext c, VoidCallback action) => buildChannel(channels[index], context)),
            ),
          );
        }, childCount: channels.length))
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var channelRequest = new ChannelRequest(pageNum: 1, pageSize: 10, name: query);
    return buildResultImpl(channelRequest);
  }

  Widget buildResultImpl(ChannelRequest channelRequest) {
    return FutureBuilder(
        future: ChannelAction.searchChannel(channelRequest),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Channel> channels = snapshot.data;
            return buildResultsComponent(channels, context);
          } else {
            return Text("");
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var channelRequest = new ChannelRequest(pageNum: 1, pageSize: 10, name: query);
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: ChannelAction.fetchSuggestion(channelRequest),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ChannelSuggestion> suggestions = snapshot.data;
            return buildSuggestionComponent(suggestions, context);
          } else {
            return Text("");
          }
        });
  }

  Widget buildSuggestionComponent(List<ChannelSuggestion> suggestions, BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${suggestions[index].name}'),
          onTap: () async {
            query = '${suggestions[index].name}';
            buildResults(context);
          },
        );
      },
    );
  }
}

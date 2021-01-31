import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/request/channel/channel_request.dart';
import 'package:flutter/material.dart';

import 'channel_action.dart';
import 'net/rest/http_result.dart';

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
            return ListTile(
              title: Text(post[0].subName, maxLines: 1),
            );
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

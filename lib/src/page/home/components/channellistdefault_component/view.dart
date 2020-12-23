import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../../channels_page.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    ChannelListDefaultState state, Dispatch dispatch, ViewService viewService) {
  StoriesType storiesType = StoriesType.channels;

  ArticleRequest articleRequest = new ArticleRequest();
  articleRequest.storiesType = storiesType;

  return Scaffold(
    body: SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
          return CustomScrollView(
            key: PageStorageKey(storiesType),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                sliver: ChannelsPage(
                  type: articleRequest,
                ),
              )
            ],
          );
        },
      ),
    ),
  );
}

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../channels_page.dart';
import 'state.dart';

Widget buildView(
    ChannelListDefaultState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
          return CustomScrollView(
            key: PageStorageKey(state.storiesType),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                sliver: ChannelsPage(
                  type: state.articleRequest,
                ),
              )
            ],
          );
        },
      ),
    ),
  );
}

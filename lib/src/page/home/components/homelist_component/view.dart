import 'package:Cruise/src/home/home_new.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'action.dart';
import 'state.dart';

final List tabs = [
  IconTab(name: "Top", icon: Feather.trending_up),
];

Widget buildView(
    HomeListState state, Dispatch dispatch, ViewService viewService) {
  StoriesType currentStoriesType = state.currentStoriesType;

  return DefaultTabController(
    length: tabs.length,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                context,
              ),
              sliver: SliverAppBar(
                title: Text(
                  'Cruise',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                pinned: true,
                expandedHeight: 10.0,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                actions: [
                  if (state.currentStoriesType == StoriesType.channels)
                    IconButton(
                      onPressed: () =>
                          {dispatch(HomeListActionCreator.onJumpAddChannel())},
                      icon: Icon(Feather.plus),
                    ),
                ],
              )),
        ];
      },
      body: TabBarView(
        children: [currentStoriesType].map((type) {
          if (currentStoriesType == StoriesType.topStories) {
            return viewService.buildComponent("homelistdefault");
          } else if (currentStoriesType == StoriesType.channels) {
            return viewService.buildComponent("channellistdefault");
          } else if (currentStoriesType == StoriesType.subStories) {
            return viewService.buildComponent("homelistdefault");
          } else if (currentStoriesType == StoriesType.favStories) {
            return viewService.buildComponent("homelistdefault");
          } else if (currentStoriesType == StoriesType.profile) {
            return viewService.buildComponent("cruisesetting");
            //return CruiseSettingsPage();
          }
        }).toList(),
      ),
    ),
  );
}

import 'package:Cruise/src/common/search.dart';
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

Widget buildView(HomeListState state, Dispatch dispatch, ViewService viewService) {
  StoriesType currentStoriesType = state.currentStoriesType;

  Widget switchNavTab(StoriesType switchStoriesType, String tabName) {
    if (state.currentStoriesType == null || state.currentStoriesType != switchStoriesType) {
      dispatch(HomeListActionCreator.onChangeStoriesType(switchStoriesType));
    }
    return viewService.buildComponent(tabName);
  }

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
                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                  ),
                ),
                pinned: true,
                expandedHeight: 10.0,
                brightness: Brightness.light, // or use Brightness.dark
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                actions: [
                  if (state.currentStoriesType == StoriesType.channels)
                    IconButton(icon: Icon(Icons.search), onPressed: (){
                      showSearch(context: context,delegate: CustomSearchDelegate());
                    }),
                    IconButton(
                      onPressed: () => {dispatch(HomeListActionCreator.onJumpAddChannel())},
                      icon: Icon(Feather.plus),
                    ),
                ],
              )),
        ];
      },
      body: TabBarView(
        children: [currentStoriesType].map((type) {
          if (currentStoriesType == StoriesType.topStories) {
            return switchNavTab(StoriesType.topStories, "homelistdefault");
          } else if (currentStoriesType == StoriesType.channels) {
            return switchNavTab(StoriesType.channels, "channellistdefault");
          } else if (currentStoriesType == StoriesType.subStories) {
            return switchNavTab(StoriesType.subStories, "homelistdefault");
          } else if (currentStoriesType == StoriesType.favStories) {
            return switchNavTab(StoriesType.favStories, "homelistdefault");
          } else if (currentStoriesType == StoriesType.profile) {
            return switchNavTab(StoriesType.profile, "cruisesetting");
          }
        }).toList(),
      ),
    ),
  );
}

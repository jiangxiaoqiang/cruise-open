import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/system_enumn.dart';
import 'package:Cruise/src/page/home/action.dart';
import 'package:Cruise/src/page/home/home_model.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  var context = viewService.context;

  void _onItemTapped(int index) {
    var homeModel = new HomeModel();
    if (index == MenuType.my.value) {
      homeModel.selectIndex = index;
      homeModel.storiesType = StoriesType.profile;
    }
    if (index == MenuType.home.value) {
      homeModel.selectIndex = index;
      homeModel.storiesType = StoriesType.topStories;
    }
    if (index == MenuType.channels.value) {
      homeModel.selectIndex = index;
      homeModel.storiesType = StoriesType.channels;
    }
    if (index == MenuType.follow.value) {
      homeModel.selectIndex = index;
      homeModel.storiesType = StoriesType.subStories;
    }
    dispatch(HomeActionCreator.onSwitchNav(homeModel));
  }

  //CruiseLocalizations cruiseLocalizations = CruiseLocalizations.of(context);
  var home = null; //cruiseLocalizations.cruiseNavigatorHome;

  return Scaffold(
    body: viewService.buildComponent("homelist"),
    bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: home == null ? "home" : home),
          BottomNavigationBarItem(icon: Icon(Icons.follow_the_signs), label: '关注'),
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: '频道'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: '我的'),
        ],
        currentIndex: state.selectIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
        unselectedItemColor: Color(0xff666666),
        type: BottomNavigationBarType.fixed),
  );
}

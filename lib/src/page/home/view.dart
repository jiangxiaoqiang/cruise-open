import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/models/home_model.dart';
import 'package:cruise/src/models/system_enumn.dart';
import 'package:cruise/src/page/home/action.dart';
import 'package:fish_redux/fish_redux.dart' as FGet;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../sub/sublistdefault_component/sub_list_default_controller.dart';
import 'state.dart';

Widget buildView(HomeState state, FGet.Dispatch dispatch, FGet.ViewService viewService) {
  var context = viewService.context;
  if (state.autoTriggerNav) {
    var homeModel = new HomeModel();
    homeModel.selectIndex = state.selectIndex;
    homeModel.storiesType = state.storiesType;
    dispatch(HomeActionCreator.onSwitchNav(homeModel));
  }

  void _onItemDoubleTapped() {
    // if tap the same navigator menu
    // navigate to the top of tab
    dispatch(HomeActionCreator.onScrollTop());
    return;
  }

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

  return Scaffold(
    body: viewService.buildComponent("homelist"),
    bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onDoubleTap: () {
                    _onItemDoubleTapped();
                  },
                  child: Icon(Icons.home)),
              label: AppLocalizations.of(context)!.cruiseNavigatorHome),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onDoubleTap: () {
                    final SubListDefaultController subListDefaultController = Get.put(SubListDefaultController());
                    subListDefaultController.updateScrollUp(true);
                  },
                  child: Icon(Icons.subscriptions)),
              label: AppLocalizations.of(context)!.cruiseNavigatorSubscribe),
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: AppLocalizations.of(context)!.cruiseNavigatorChannel),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: AppLocalizations.of(context)!.cruiseNavigatorMine),
        ],
        currentIndex: state.selectIndex,
        fixedColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
        unselectedItemColor: Color(0xff666666),
        type: BottomNavigationBarType.fixed),
  );
}

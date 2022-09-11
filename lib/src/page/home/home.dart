import 'package:cruise/src/component/home_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../models/enumn/stories_type.dart';
import '../../models/home_model.dart';
import '../../models/system_enumn.dart';
import 'home_controller.dart';

class HomeDefault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          //var context = viewService.context;
          if (controller.autoTriggerNav) {
            var homeModel = new HomeModel();
            homeModel.selectIndex = controller.selectIndex;
            homeModel.storiesType = controller.storiesType;
            //dispatch(HomeActionCreator.onSwitchNav(homeModel));
          }

          void _onItemDoubleTapped() {
            // if tap the same navigator menu
            // navigate to the top of tab
            //dispatch(HomeActionCreator.onScrollTop());
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
            //dispatch(HomeActionCreator.onSwitchNav(homeModel));
          }

          return Scaffold(
              body: new HomeList(currentStoriesType: controller.storiesType),
              bottomNavigationBar: GestureDetector(
                onDoubleTap: () {
                  _onItemDoubleTapped();
                },
                child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context)!.cruiseNavigatorHome),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.subscriptions), label: AppLocalizations.of(context)!.cruiseNavigatorSubscribe),
                      BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: AppLocalizations.of(context)!.cruiseNavigatorChannel),
                      BottomNavigationBarItem(icon: Icon(Icons.school), label: AppLocalizations.of(context)!.cruiseNavigatorMine),
                    ],
                    currentIndex: controller.selectIndex,
                    fixedColor: Theme.of(context).primaryColor,
                    onTap: _onItemTapped,
                    unselectedItemColor: Color(0xff666666),
                    type: BottomNavigationBarType.fixed),
              ));
        });
  }
}

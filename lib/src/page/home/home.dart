import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../models/enumn/stories_type.dart';
import '../../models/home_model.dart';
import '../../models/system_enumn.dart';
import '../sub/sublistdefault_component/sub_list_default_controller.dart';
import 'components/homelist_component/home_list.dart';
import 'components/homelist_component/home_list_controller.dart';
import 'components/homelistdefault_component/home_list_default_controller.dart';
import 'home_controller.dart';

class HomeDefault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          if (controller.autoTriggerNav.value) {
            var homeModel = new HomeModel();
            homeModel.selectIndex = controller.selectIndex.value;
            homeModel.storiesType = controller.storiesType.value;
          }

          void _onItemTapped(int index) {
            final HomeListController homeListController = Get.put(HomeListController());
            if (index == MenuType.my.value) {
              controller.updateNav(index, StoriesType.profile);
              homeListController.updateStories(StoriesType.profile);
            }
            if (index == MenuType.home.value) {
              controller.updateNav(index, StoriesType.topStories);
              homeListController.updateStories(StoriesType.topStories);
            }
            if (index == MenuType.channels.value) {
              controller.updateNav(index, StoriesType.channels);
              homeListController.updateStories(StoriesType.channels);
            }
            if (index == MenuType.sub.value) {
              controller.updateNav(index, StoriesType.subStories);
              homeListController.updateStories(StoriesType.subStories);
            }
          }

          return Scaffold(
            body: new HomeList(),
            bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: GestureDetector(
                          onDoubleTap: () {
                            final HomeListDefaultController subListDefaultController = Get.put(HomeListDefaultController());
                            subListDefaultController.updateScroll(true);
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
                currentIndex: controller.selectIndex.value,
                fixedColor: Theme.of(context).primaryColor,
                onTap: _onItemTapped,
                unselectedItemColor: Color(0xff666666),
                type: BottomNavigationBarType.fixed),
          );
        });
  }
}

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../models/enumn/stories_type.dart';
import '../../../../widgets/app/global_controller.dart';
import '../../../channel/add_channel.dart';
import '../../../channel/channellistdefault_component/channel_list_default.dart';
import '../../../channel/channellistdefault_component/channel_list_default_controller.dart';
import '../../../sub/sublistdefault_component/sub_list_default.dart';
import '../../../sub/sublistdefault_component/sub_list_default_controller.dart';
import '../../../user/settings/cruisesetting/cruise_setting_page.dart';
import '../homelistdefault_component/home_list_default.dart';
import '../homelistdefault_component/home_list_default_controller.dart';
import 'home_list_controller.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeListController>(
        init: HomeListController(),
        builder: (controller) {
          StoriesType currentStoriesType = controller.currentStoriesType.value;
          final GlobalController globalController = Get.put(GlobalController());

          Widget nav(StoriesType currentStoriesType) {
            if (currentStoriesType == StoriesType.topStories) {
              globalController.appBarTitle.value = AppLocalizations.of(context)!.cruiseNavigatorHome;
              final HomeListDefaultController subListDefaultController = Get.put(HomeListDefaultController());
              subListDefaultController.initArticles(StoriesType.topStories);
              subListDefaultController.currentStoriesType = StoriesType.topStories;
              return HomeListDefault();
            } else if (currentStoriesType == StoriesType.channels) {
              globalController.appBarTitle.value = AppLocalizations.of(context)!.cruiseNavigatorChannel;
              final ChannelListDefaultController subListDefaultController = Get.put(ChannelListDefaultController());
              subListDefaultController.init();
              return ChannelListDefault();
            } else if (currentStoriesType == StoriesType.subStories) {
              globalController.appBarTitle.value = AppLocalizations.of(context)!.cruiseNavigatorSubscribe;
              final SubListDefaultController subListDefaultController = Get.put(SubListDefaultController());
              subListDefaultController.initArticles();
              subListDefaultController.currentStoriesType = StoriesType.subStories;
              return SubListDefault();
            } else if (currentStoriesType == StoriesType.favStories) {
              final HomeListDefaultController subListDefaultController = Get.put(HomeListDefaultController());
              subListDefaultController.currentStoriesType = StoriesType.favStories;
              subListDefaultController.articles = controller.articles;
              return HomeListDefault();
            } else if (currentStoriesType == StoriesType.profile) {
              globalController.appBarTitle.value = AppLocalizations.of(context)!.cruiseNavigatorMine;
              return new CruiseSettingPage();
            } else if (currentStoriesType == StoriesType.originalStories) {
              final HomeListDefaultController subListDefaultController = Get.put(HomeListDefaultController());
              subListDefaultController.articles = controller.articles;
              subListDefaultController.currentStoriesType = StoriesType.originalStories;
              return HomeListDefault();
            } else if (currentStoriesType == StoriesType.historyStories) {
              final HomeListDefaultController subListDefaultController = Get.put(HomeListDefaultController());
              subListDefaultController.articles = controller.articles;
              subListDefaultController.currentStoriesType = StoriesType.historyStories;
              return HomeListDefault();
            }
            return Container();
          }

          return DefaultTabController(
            length: 1,
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context,
                      ),
                      sliver: SliverAppBar(
                        centerTitle: true,
                        title: Text(
                          globalController.appBarTitle.value,
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                          ),
                        ),
                        pinned: true,
                        expandedHeight: 10.0,
                        brightness: Brightness.light,
                        // or use Brightness.dark
                        floating: true,
                        snap: true,
                        forceElevated: innerBoxIsScrolled,
                        actions: [
                          if (controller.currentStoriesType == StoriesType.channels)
                            IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  // showSearch(context: context, delegate: CustomSearchDelegate(viewService));
                                }),
                          if (controller.currentStoriesType == StoriesType.channels)
                            IconButton(
                              onPressed: () {
                                Widget page = AddChannel();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => page),
                                );
                              },
                              icon: Icon(EvaIcons.plus),
                            ),
                        ],
                      )),
                ];
              },
              body: TabBarView(
                children: [currentStoriesType].map((type) {
                  return nav(type);
                }).toList(),
              ),
            ),
          );
        });
  }
}

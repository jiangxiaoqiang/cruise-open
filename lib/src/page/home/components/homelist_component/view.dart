import 'package:cruise/src/common/search.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/page/channel/add_channel.dart';
import 'package:cruise/src/page/sub/sublistdefault_component/sub_list_default.dart';
import 'package:cruise/src/page/user/settings/cruisesetting/cruise_setting_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fish_redux/fish_redux.dart' as Redux;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../widgets/app/global_controller.dart';
import '../../../sub/sublistdefault_component/sub_list_default_controller.dart';
import '../homelistdefault_component/home_list_default.dart';
import '../homelistdefault_component/home_list_default_controller.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(HomeListState state, Redux.Dispatch dispatch, Redux.ViewService viewService) {
  StoriesType currentStoriesType = state.currentStoriesType;
  final GlobalController globalController = Get.put(GlobalController());

  Widget switchNavTab(StoriesType switchStoriesType, String tabName) {
    if (state.currentStoriesType == null || state.currentStoriesType != switchStoriesType) {
      dispatch(HomeListActionCreator.onChangeStoriesType(switchStoriesType));
    }
    return viewService.buildComponent(tabName);
  }

  Widget nav(StoriesType currentStoriesType) {
    if (currentStoriesType == StoriesType.topStories) {
      globalController.appBarTitle.value = AppLocalizations.of(viewService.context)!.cruiseNavigatorHome;
      final HomeListDefaultController subListDefaultController = Get.put(HomeListDefaultController());
      subListDefaultController.initArticles(StoriesType.topStories);
      subListDefaultController.currentStoriesType = StoriesType.topStories;
      return HomeListDefault();
    } else if (currentStoriesType == StoriesType.channels) {
      globalController.appBarTitle.value = AppLocalizations.of(viewService.context)!.cruiseNavigatorChannel;
      return switchNavTab(StoriesType.channels, "channellistdefault");
    } else if (currentStoriesType == StoriesType.subStories) {
      globalController.appBarTitle.value = AppLocalizations.of(viewService.context)!.cruiseNavigatorSubscribe;
      final SubListDefaultController subListDefaultController = Get.put(SubListDefaultController());
      subListDefaultController.initArticles();
      subListDefaultController.currentStoriesType = StoriesType.subStories;
      return SubListDefault();
    } else if (currentStoriesType == StoriesType.favStories) {
      final HomeListDefaultController subListDefaultController = Get.put(HomeListDefaultController());
      subListDefaultController.initArticles(StoriesType.favStories);
      subListDefaultController.currentStoriesType = StoriesType.favStories;
      return HomeListDefault();
    } else if (currentStoriesType == StoriesType.profile) {
      globalController.appBarTitle.value = AppLocalizations.of(viewService.context)!.cruiseNavigatorMine;
      return new CruiseSettingPage();
    } else if (currentStoriesType == StoriesType.originalStories) {
      final HomeListDefaultController subListDefaultController = Get.put(HomeListDefaultController());
      subListDefaultController.initArticles(StoriesType.originalStories);
      subListDefaultController.currentStoriesType = StoriesType.originalStories;
      return HomeListDefault();
    } else if (currentStoriesType == StoriesType.historyStories) {
      final HomeListDefaultController subListDefaultController = Get.put(HomeListDefaultController());
      subListDefaultController.initArticles(StoriesType.historyStories);
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
                  if (state.currentStoriesType == StoriesType.channels)
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(context: context, delegate: CustomSearchDelegate(viewService));
                        }),
                  if (state.currentStoriesType == StoriesType.channels)
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
}

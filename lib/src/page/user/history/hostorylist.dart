import 'package:cruise/src/page/home/components/homelist_component/home_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/enumn/stories_type.dart';
import '../../home/components/homelist_component/home_list_controller.dart';
import 'historylist_controller.dart';

class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
        init: HistoryController(),
        builder: (controller) {
          Widget navDiscoverList() {
            final HomeListController homeListController = Get.put(HomeListController());
            homeListController.currentStoriesType.value = StoriesType.historyStories;
            return FutureBuilder(
                future: homeListController.initArticles(StoriesType.historyStories),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    homeListController.articles = snapshot.data;
                    return new HomeList();
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
          }

          return Scaffold(body: SafeArea(child: navDiscoverList()));
        });
  }
}

import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/page/home/components/homelist_component/home_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/components/homelist_component/home_list_controller.dart';
import 'fav_controller.dart';

class Fav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavController>(
        init: FavController(),
        builder: (controller) {
          Widget navDiscoverList() {
            final HomeListController homeListController = Get.put(HomeListController());
            homeListController.currentStoriesType.value = StoriesType.favStories;
            return new HomeList();
          }

          return Scaffold(body: SafeArea(child: navDiscoverList()));
        });
  }
}

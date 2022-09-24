import 'package:cruise/src/page/home/components/homelist_component/home_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fav_controller.dart';

class Fav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavController>(
        init: FavController(),
        builder: (controller) {
          Widget navDiscoverList() {
            return new HomeList();
          }

          return Scaffold(body: SafeArea(child: navDiscoverList()));
        });
  }
}

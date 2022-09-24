import 'package:cruise/src/page/home/components/homelist_component/home_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'history_controller.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
        init: HistoryController(),
        builder: (controller) {
          Widget navDiscoverList() {
            return new HomeList();
          }

          return Scaffold(body: SafeArea(child: navDiscoverList()));
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'version_controller.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivicyController>(
        init: PrivicyController(),
        builder: (controller) {
          return Scaffold(
              body: SafeArea(
                  child: Container(
                      child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text('''
      v1.0.0(当前最新版本)
      
      1、RSS信息流阅读
      2、RSS频道订阅
      3、新增RSS频道
      4、检索RSS频道
      5、RSS文章点赞、收藏
      '''),
            ),
          ))));
        });
  }
}

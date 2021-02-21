import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(VersionState state, Dispatch dispatch, ViewService viewService) {
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
}

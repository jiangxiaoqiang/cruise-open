import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cruise/src/common/config/cruise_global_config.dart' as global;

import 'state.dart';

Widget buildView(
    ArticlePgState state, Dispatch dispatch, ViewService viewService) {
  Item item = state.article;
  Map<String, ScrollController> scrollControllers = state.scrollControllers;
  Widget navDetail(Item article) {
    return viewService.buildComponent("articledetail");
  }

  return PageStorage(
      bucket: global.pageStorageBucket,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cruise'),
          brightness: Brightness.light, // or use Brightness.dark
          actions: [],
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            //scrollController.animateTo(scrollController.offset, duration: Duration(milliseconds: 1000), curve: Curves.ease);
            return true;
          },
          child: CupertinoScrollbar(
              child: CustomScrollView(
            key: PageStorageKey(item.id),
            controller: scrollControllers[item.id.toString()],
            slivers: [
              SliverToBoxAdapter(child: navDetail(item)),
              //CommentList(item: item),
            ],
          )),
        ),
      ));
}

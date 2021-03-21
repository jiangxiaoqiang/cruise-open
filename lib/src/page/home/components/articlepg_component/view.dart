import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(ArticlePgState state, Dispatch dispatch, ViewService viewService) {
  Item item = state.article;
  var showToTopBtn = state.showToTopBtn;
  PageStorageBucket pageStorageBucket = state.pageStorageBucket;
  Map<String, ScrollController> scrollControllers = state.scrollControllers;
  ScrollController scrollController = scrollControllers.length == 0 ? ScrollController() : scrollControllers[item.id]!;
  scrollController.addListener(() => {
        if (scrollController.offset < 1000) {showToTopBtn = false} else if (scrollController.offset >= 1000) {showToTopBtn = true}
      });

  Widget navDetail(Item article) {
    return viewService.buildComponent("articledetail");
  }

  return PageStorage(
      bucket: pageStorageBucket,
      child: Scaffold(
        appBar: AppBar(
          title: Text('cruise'),
          brightness: Brightness.light, // or use Brightness.dark
          actions: [],
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
            return true;
          },
          child: CustomScrollView(
            key: PageStorageKey(item.id),
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(child: navDetail(item)),
              //CommentList(item: item),
            ],
          ),
        ),
        floatingActionButton: !showToTopBtn
            ? null
            : FloatingActionButton(
                child: Icon(Icons.arrow_upward),
                onPressed: () {
                  if (scrollController.hasClients) {
                    scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
                  }
                }),
      ));
}

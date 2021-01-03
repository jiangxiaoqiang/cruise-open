import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/component/story_information.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ArticlePgState state, Dispatch dispatch, ViewService viewService) {
  Item item = new Item();
  item.id = 1112.toString();
  item.title = "ddd";
  var showToTopBtn = state.showToTopBtn;
  PageStorageBucket pageStorageBucket = state.pageStorageBucket;
  ScrollController scrollController;
  Map<String, ScrollController> scrollControllers = state.scrollControllers;
  scrollController = scrollControllers[item.id];

  if (scrollController != null) {
    scrollController.addListener(() => {
          if (scrollController.offset < 1000)
            {showToTopBtn = false}
          else if (scrollController.offset >= 1000)
            {showToTopBtn = true}
        });
  }

  return PageStorage(
      bucket: pageStorageBucket,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cruise'),
          actions: [
            if (item.parent != null)
              IconButton(
                icon: Icon(Feather.corner_left_up),
                onPressed: () async {
                  Item parent = await Repo.fetchArticleItem(item.parent);
                },
              ),
          ],
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {},
          child: CustomScrollView(
            key: PageStorageKey(item.id),
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                  child: viewService.buildComponent("articledetail")),
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
                    scrollController.animateTo(.0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.ease);
                  }
                }),
      ));
}

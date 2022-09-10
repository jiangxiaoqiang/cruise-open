import 'package:cruise/src/common/config/cruise_global_config.dart' as global;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/Item.dart';
import '../articledetail_component/article_detail.dart';
import '../articledetail_component/article_detail_controller.dart';
import 'article_pg_controller.dart';

class ArticlePg extends StatelessWidget {
  Widget navDetail(Item article, ArticlePgController articlePgController) {
    final ArticleDetailController articleDetailController = Get.put(ArticleDetailController());
    articleDetailController.initArticle(int.parse(article.id));
    return new ArticleDetail();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticlePgController>(
        init: ArticlePgController(),
        builder: (controller) {
          Item item = controller.article;
          Map<String, ScrollController> scrollControllers = controller.scrollControllers;

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
                      SliverToBoxAdapter(child: navDetail(item, controller)),
                      //CommentList(item: item),
                    ],
                  )),
                ),
              ));
        });
  }
}

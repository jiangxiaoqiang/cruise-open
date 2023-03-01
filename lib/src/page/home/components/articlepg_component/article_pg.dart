import 'package:cruise/src/common/config/cruise_global_config.dart' as global;
import 'package:cruise/src/page/home/components/articledetail_component/article_detail_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/Item.dart';
import '../articledetail_component/article_detail_controller.dart';
import 'article_pg_controller.dart';

class ArticlePg extends StatelessWidget {
  Widget navDetail(ArticleItem article, ArticlePgController articlePgController) {
    final ArticleDetailController articleDetailController = Get.put(ArticleDetailController());
    articleDetailController.article = article;
    articleDetailController.changeKey(article.id);
    return new ArticleDetailWrapper();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticlePgController>(
        init: ArticlePgController(),
        builder: (controller) {
          ArticleItem item = controller.article;

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
                    key: PageStorageKey("article-page-" + item.id),
                    //controller: new ScrollController(),
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

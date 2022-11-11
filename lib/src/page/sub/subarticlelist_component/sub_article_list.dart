import 'package:animations/animations.dart';
import 'package:cruise/src/page/home/components/articlepg_component/article_pg_controller.dart';
import 'package:cruise/src/page/sub/subarticlelist_component/sub_article_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../common/helpers.dart';
import '../../../common/view_manager.dart';
import '../../../models/Item.dart';

class SubArticleList extends StatelessWidget {
  Widget buildArticle(ArticleItem item) {
    final ArticlePgController articlePgController = Get.put(ArticlePgController());
    return articlePgController.buildArticlePage(item);
  }

  final currentView = ViewManager.fromViewName("itemCard");

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubArticleListController>(
        init: SubArticleListController(),
        builder: (controller) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Slidable(
                key: Key("article-list-" + controller.subArticles[index].id.toString()),
                closeOnScroll: true,
                actionPane: SlidableScrollActionPane(),
                actions: <Widget>[],
                dismissal: SlidableDismissal(
                  closeOnCanceled: true,
                  dismissThresholds: {
                    SlideActionType.primary: 0.2,
                    SlideActionType.secondary: 0.2,
                  },
                  child: SlidableDrawerDismissal(),
                  onWillDismiss: (actionType) {
                    //handleUpvote(context, item: item);
                    return false;
                  },
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: OpenContainer(
                    tappable: true,
                    closedElevation: 0,
                    closedColor: Theme.of(context).scaffoldBackgroundColor,
                    openColor: Theme.of(context).scaffoldBackgroundColor,
                    transitionDuration: Duration(milliseconds: 500),
                    closedBuilder: (BuildContext c, VoidCallback action) => getViewType(currentView, controller.subArticles[index]),
                    openBuilder: (BuildContext c, VoidCallback action) => buildArticle(controller.subArticles[index]),
                  ),
                ),
              );
            }, childCount: controller.subArticles.length),
          );
        });
  }
}

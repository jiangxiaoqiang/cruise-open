import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/helpers.dart';
import '../../../../common/view_manager.dart';
import '../../../../models/Item.dart';
import '../articlepg_component/article_pg.dart';
import '../articlepg_component/article_pg_controller.dart';
import 'article_list_controller.dart';

const APPBAR_SCROLL_OFFSET = 100;
double appBarAlpha = 0;
bool isDispatched = false;
RefreshController _refreshController = RefreshController(initialRefresh: false);
ScrollController scrollController = ScrollController();

class ArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticleListController>(
        init: ArticleListController(),
        builder: (controller) {
          Widget buildArticle(Item item) {
            final ArticlePgController articlePgController = Get.put(ArticlePgController());
            articlePgController.article = item;
            return new ArticlePg();
          }

          final currentView = ViewManager.fromViewName("itemCard");

          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Slidable(
                key: Key("article-list-" + controller.articles[index].id.toString()),
                closeOnScroll: true,
                actionPane: SlidableScrollActionPane(),
                actions: <Widget>[
                  /*IconSlideAction(
            color: Colors.deepOrangeAccent,
            icon: Feather.arrow_up_circle,
            //onTap: () => handleUpvote(context, item: item),
          ),*/
                ],
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
                    closedBuilder: (BuildContext c, VoidCallback action) => getViewType(currentView, controller.articles[index]),
                    openBuilder: (BuildContext c, VoidCallback action) => buildArticle(controller.articles[index]),
                  ),
                ),
              );
            }, childCount: controller.articles.length),
          );
        });
  }
}

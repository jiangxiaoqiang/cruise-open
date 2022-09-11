import 'package:animations/animations.dart';
import 'package:cruise/src/common/helpers.dart';
import 'package:cruise/src/common/view_manager.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart' as Redux;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../articlepg_component/article_pg.dart';
import '../articlepg_component/article_pg_controller.dart';
import 'state.dart';

Widget buildView(ArticleListState state, Redux.Dispatch dispatch, Redux.ViewService viewService) {
  Widget buildArticle(Item item) {
    final ArticlePgController articlePgController = Get.put(ArticlePgController());
    articlePgController.article = item;
    return new ArticlePg();
  }

  final currentView = ViewManager.fromViewName("itemCard");

  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      return Slidable(
        key: Key("article-list-" + state.articles[index].id.toString()),
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
            closedBuilder: (BuildContext c, VoidCallback action) => getViewType(currentView, state.articles[index]),
            openBuilder: (BuildContext c, VoidCallback action) => buildArticle(state.articles[index]),
          ),
        ),
      );
    }, childCount: state.articles.length),
  );
}

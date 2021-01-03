import 'package:Cruise/src/common/view_manager.dart';
import 'package:Cruise/src/component/compact_tile.dart';
import 'package:Cruise/src/component/item_card.dart';
import 'package:Cruise/src/component/item_tile.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:animations/animations.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'state.dart';

Widget buildView(
    ArticleListState state, Dispatch dispatch, ViewService viewService) {
  _getViewType(ViewType type, Item item) {
    switch (type) {
      case ViewType.compactTile:
        return CompactTile(item: item);
        break;
      case ViewType.itemCard:
        return ItemCard(item: item);
        break;
      case ViewType.itemTile:
        return ItemTile(item: item);
        break;
      default:
        return ItemCard(item: item);
        break;
    }
  }

  Widget buildArticle(Item item) {
   return viewService.buildComponent("articlepg");

    /*if (item != null) {
      viewService.buildComponent("articlepage");
      dispatch(ArticleListActionCreator.onSetDetailArticle(item));
    } else {
      return Container(width: 0.0, height: 0.0);
    }*/
  }

  final currentView = ViewManager.fromViewName("itemCard");

  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      return Slidable(
        key: Key(state.articles[index].id.toString()),
        closeOnScroll: true,
        actionPane: SlidableScrollActionPane(),
        actions: <Widget>[
          IconSlideAction(
            color: Colors.deepOrangeAccent,
            icon: Feather.arrow_up_circle,
            //onTap: () => handleUpvote(context, item: item),
          ),
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
            closedBuilder: (BuildContext c, VoidCallback action) =>
                _getViewType(currentView, state.articles[index]),
            openBuilder: (BuildContext c, VoidCallback action) =>
                buildArticle(state.articles[index]),
          ),
        ),
      );
    }, childCount: state.articles.length),
  );
}

import 'package:Cruise/src/common/theme.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:Cruise/src/component/channel_compact_tile.dart';
import 'package:Cruise/src/component/channel_item_card.dart';
import 'package:Cruise/src/component/channel_item_tile.dart';
import 'package:Cruise/src/component/loading_item.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:animations/animations.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../channel_page.dart';
import '../../channels_page.dart';
import 'action.dart';
import 'state.dart';

_getChannelViewType(ViewType type, Channel item) {
  switch (type) {
    case ViewType.compactTile:
      return ChannelCompactTile(item: item);
      break;
    case ViewType.itemCard:
      return ChannelItemCard(item: item);
      break;
    case ViewType.itemTile:
      return ChannelItemTile(item: item);
      break;
    default:
      return ChannelItemCard(item: item);
      break;
  }
}

Widget buildView(ChannelListState state, Dispatch dispatch, ViewService viewService) {

  final currentTheme = ThemeManager.fromThemeName("lightTheme");
  final currentView = ViewManager.fromViewName("itemCard");

  return SliverList(
    delegate: SliverChildBuilderDelegate(
          (context, index) {
        /*return Consumer(
              (context, read) {
            return read(storyChannelProvider(state.ids[index])).when(
              loading: () => LoadingItem(count: 1),
              error: (err, trace) => Text("Error: $err"),
              data: (item) {
                if(item == null){
                  return Text("");
                }
                return Slidable(
                  key: Key(item.id.toString()),
                  closeOnScroll: true,
                  actionPane: SlidableScrollActionPane(),
                  actions: <Widget>[
                    IconSlideAction(
                      color: Colors.deepOrangeAccent,
                      icon: Feather.arrow_up_circle,
                      onTap: () => {},
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
                      closedColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      openColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      transitionDuration: Duration(milliseconds: 500),
                      closedBuilder:
                          (BuildContext c, VoidCallback action) =>
                          _getChannelViewType(currentView, item),
                      openBuilder:
                          (BuildContext c, VoidCallback action) =>
                          ChannelPage(item: item),
                    ),
                  ),
                );
              },
            );
          },
        );*/
      },
      childCount: state.ids.length,
    ),
  );
}

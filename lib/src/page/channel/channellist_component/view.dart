import 'package:Cruise/src/common/utils/common_utils.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:Cruise/src/component/channel_compact_tile.dart';
import 'package:Cruise/src/component/channel_item_card.dart';
import 'package:Cruise/src/component/channel_item_tile.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/page/channel/channellist_component/action.dart';
import 'package:animations/animations.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'state.dart';

Widget buildView(ChannelListState state, Dispatch dispatch, ViewService viewService) {

  final currentView = ViewManager.fromViewName("itemCard");

  Widget buildChannel(Channel channel) {
    dispatch(ChannelListActionCreator.onSetDetailChannel(channel));
    return viewService.buildComponent("articlepg");
  }

  return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
    return Slidable(
      key: Key(state.channels[index].id.toString()),
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
            closedColor: Theme.of(context).scaffoldBackgroundColor,
            openColor: Theme.of(context).scaffoldBackgroundColor,
            transitionDuration: Duration(milliseconds: 500),
            closedBuilder: (BuildContext c, VoidCallback action) =>CommonUtils.getChannelViewType(currentView, state.channels[index]),
            openBuilder: (BuildContext c, VoidCallback action) => buildChannel(state.channels[index])),
      ),
    );
  }, childCount: state.channels.length));
}

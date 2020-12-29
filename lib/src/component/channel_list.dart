import 'package:Cruise/src/component/channel_item_tile.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/page/channel_page.dart';
import 'package:Cruise/src/page/channels_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:Cruise/src/component/loading_item.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'channel_compact_tile.dart';
import 'channel_item_card.dart';

class ChannelList extends HookWidget {
  const ChannelList({
    Key key,
    @required this.ids,
  }) : super(key: key);

  final List<int> ids;

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


  @override
  Widget build(BuildContext context) {

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          /*return Consumer(
                (context, read) {
              return read(storyChannelProvider(ids[index])).when(
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
        childCount: ids.length,
      ),
    );
  }

}

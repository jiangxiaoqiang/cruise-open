import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../common/utils/cruise_common_utils.dart';
import '../../../common/view_manager.dart';
import '../../../models/Channel.dart';
import '../channelpg_component/channel_pg.dart';
import '../channelpg_component/channel_pg_controller.dart';
import 'channel_list_controller.dart';

class ChannelList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChannelListController>(
        init: ChannelListController(),
        builder: (controller) {
          final currentView = ViewManager.fromViewName("itemCard");

          Widget buildChannel(Channel channel) {
            final ChannelPgController articlePgController = Get.put(ChannelPgController());
            articlePgController.channelId.value = channel.id;
            return ChannelPg();
          }

          return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Slidable(
              key: Key(controller.channels[index].id.toString()),
              closeOnScroll: true,
              actionPane: SlidableScrollActionPane(),
              actions: <Widget>[
                /* IconSlideAction(
          color: Colors.deepOrangeAccent,
          icon: Feather.arrow_up_circle,
          onTap: () => {},
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
                    closedBuilder: (BuildContext c, VoidCallback action) =>
                        CruiseCommonUtils.getChannelViewType(currentView, controller.channels[index]),
                    openBuilder: (BuildContext c, VoidCallback action) => buildChannel(controller.channels[index])),
              ),
            );
          }, childCount: controller.channels.length));
        });
  }
}

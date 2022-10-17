import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/repo.dart';
import '../../../models/Channel.dart';
import '../channeldetail_component/channel_detail.dart';
import '../channeldetail_component/channel_detail_controller.dart';
import 'channel_pg_controller.dart';

class ChannelPg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChannelPgController>(
        init: ChannelPgController(),
        builder: (controller) {
          Channel item = controller.channel.value;

          Widget navChannelDetail(Channel channel) {
            final ChannelDetailController articlePgController = Get.put(ChannelDetailController());
            articlePgController.channel = item;
            articlePgController.getChannelArticles(int.parse(item.id));
            return new ChannelDetail();
          }

          void navChannelPg(Channel channel) {
            final ChannelPgController articlePgController = Get.put(ChannelPgController());
            articlePgController.channel.value = channel;
            Get.to(ChannelPg());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Cruise'),
              brightness: Brightness.light, // or use Brightness.dark
              actions: [
                if (item.parent != null)
                  IconButton(
                    icon: Icon(EvaIcons.cornerLeftUp),
                    onPressed: () async {
                      Channel parent = (await Repo.fetchChannelItem(item.parent))!;
                      navChannelPg(parent);
                    },
                  ),
              ],
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: navChannelDetail(item)),
              ],
            ),
          );
        });
  }
}

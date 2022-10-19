import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../channeldetail_component/channel_detail.dart';
import '../channeldetail_component/channel_detail_controller.dart';
import 'channel_pg_controller.dart';

class ChannelPg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChannelPgController>(
        init: ChannelPgController(),
        builder: (controller) {
          Widget navChannelDetail(String channelId) {
            final ChannelDetailController channelDetailController = Get.put(ChannelDetailController());
            channelDetailController.getChannelArticles(int.parse(channelId));
            return new ChannelDetail();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Cruise'),
              brightness: Brightness.light, // or use Brightness.dark
              actions: [],
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: navChannelDetail(controller.channelId.value)),
              ],
            ),
          );
        });
  }
}

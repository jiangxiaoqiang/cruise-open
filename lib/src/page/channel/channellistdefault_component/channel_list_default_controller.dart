import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:synchronized/synchronized.dart';

import '../../../common/repo.dart';
import '../../../models/Channel.dart';
import '../../../models/Item.dart';
import '../../../models/request/channel/channel_request.dart';

class ChannelListDefaultController extends GetxController {
  ChannelRequest articleRequest = new ChannelRequest(pageNum: 1, pageSize: 15, name: '');
  LoadingStatus channelLoadingStatus = LoadingStatus.loading;
  bool isScrollTop = false;
  List<Channel> channels = List<Channel>.empty(growable: true);
  var lock = new Lock();

  Future init() async {
    return await lock.synchronized(() async {
      ChannelRequest articleRequest = new ChannelRequest(pageSize: 15, pageNum: 1, name: '');
      List<Channel> fetchedChannel = await Repo.getChannels(articleRequest);
      if (fetchedChannel.isNotEmpty) {
        channels.addAll(fetchedChannel);
        update();
      }
    });
  }

  void loadingMoreChannel(RefreshController _refreshController) async {
    articleRequest.pageNum = articleRequest.pageNum + 1;
    List<Channel> serverChannels = await Repo.getChannels(articleRequest);
    channels.addAll(serverChannels.where((a) => channels.every((b) => a.id != b.id)));
    _refreshController.loadComplete();
    update();
  }
}

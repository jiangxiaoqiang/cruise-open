import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../common/repo.dart';
import '../../../models/Channel.dart';
import '../../../models/Item.dart';
import '../../../models/enumn/stories_type.dart';
import '../../../models/request/article/article_request.dart';

class ChannelListDefaultController extends GetxController {
  ArticleRequest articleRequest = new ArticleRequest(pageNum: 1, pageSize: 15, storiesType: StoriesType.channels);
  LoadingStatus channelLoadingStatus = LoadingStatus.loading;
  bool isScrollTop = false;
  List<Channel> channels = List<Channel>.empty(growable: true);

  Future init() async {
    ArticleRequest articleRequest = new ArticleRequest(pageSize: 15, pageNum: 1, storiesType: StoriesType.channels);
    List<Channel> fetchedChannel = await Repo.getChannels(articleRequest);
    if (fetchedChannel.isNotEmpty) {
      channels.addAll(fetchedChannel);
      update();
    }
  }

  void loadingMoreChannel(RefreshController _refreshController) async {
    articleRequest.pageNum = articleRequest.pageNum + 1;
    List<Channel> serverChannels = await Repo.getChannels(articleRequest);
    channels.addAll(serverChannels.where((a) => channels.every((b) => a.id != b.id)));
    _refreshController.loadComplete();
    update();
  }
}

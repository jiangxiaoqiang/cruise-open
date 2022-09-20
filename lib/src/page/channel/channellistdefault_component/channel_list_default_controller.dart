import 'package:get/get.dart';

import '../../../common/repo.dart';
import '../../../models/Channel.dart';
import '../../../models/Item.dart';
import '../../../models/enumn/stories_type.dart';
import '../../../models/request/article/article_request.dart';

class ChannelListDefaultController extends GetxController {
  ArticleRequest articleRequest = new ArticleRequest(pageNum: 1, pageSize: 15, storiesType: StoriesType.channels);
  LoadingStatus channelLoadingStatus = LoadingStatus.loading;
  bool isScrollTop = false;
  RxList<Channel> channels = List<Channel>.empty(growable: true).obs;

  Future init() async {
    ArticleRequest articleRequest = new ArticleRequest(pageSize: 15, pageNum: 1, storiesType: StoriesType.channels);
    List<Channel> fetchedChannel = await Repo.getChannels(articleRequest);
    if (fetchedChannel.isNotEmpty) {
      channels.value.addAll(fetchedChannel);
      update();
    }
  }
}

import 'package:get/get.dart';

import '../../../common/repo.dart';
import '../../../models/Channel.dart';
import '../../../models/Item.dart';
import '../../../models/enumn/stories_type.dart';
import '../../../models/request/article/article_request.dart';

class ChannelDetailController extends GetxController {
  var channel = Channel().obs;
  int isFav = 0;
  StoriesType? currentStoriesType;
  ArticleRequest? articleRequest;
  RxList<Item> articles = List<Item>.empty(growable: true).obs;

  void updateChannelFav(int isFav) {
    channel.value.isFav = isFav;
    update();
  }

  Future<void> getChannelArticles(int channelId) async {
    Channel? channelResponse = await Repo.fetchChannelItem(channelId);
    if (channelResponse != null) {
      channel.value = channelResponse;
      if (channelResponse.articleDTOList != null) {
        articles.value = channelResponse.articleDTOList!;
      }
      update();
    }
  }
}

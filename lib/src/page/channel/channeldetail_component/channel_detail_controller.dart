import 'package:get/get.dart';

import '../../../common/repo.dart';
import '../../../models/Channel.dart';
import '../../../models/Item.dart';
import '../../../models/enumn/stories_type.dart';
import '../../../models/request/article/article_request.dart';

class ChannelDetailController extends GetxController {
  var channel = Channel();
  int isFav = 0;
  StoriesType? currentStoriesType;
  ArticleRequest? articleRequest;
  List<ArticleItem> channelDetailArticles = List<ArticleItem>.empty(growable: true);

  void updateChannelFav(int isFav) {
    channel.isFav = isFav;
    update();
  }

  Future<void> getChannelArticles(int channelId) async {
    Channel? channelResponse = await Repo.fetchChannelItem(channelId);
    if (channelResponse != null) {
      channel = channelResponse;
      if (channelResponse.articleDTOList != null) {
        channelDetailArticles = channelResponse.articleDTOList!;
      }
      update();
    }
  }
}

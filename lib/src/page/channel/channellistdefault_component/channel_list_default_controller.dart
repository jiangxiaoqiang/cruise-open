import 'package:get/get.dart';

import '../../../models/Channel.dart';
import '../../../models/Item.dart';
import '../../../models/enumn/stories_type.dart';
import '../../../models/request/article/article_request.dart';

class ChannelListDefaultController extends GetxController {
  ArticleRequest articleRequest = new ArticleRequest(pageNum: 1, pageSize: 15, storiesType: StoriesType.channels);
  LoadingStatus channelLoadingStatus = LoadingStatus.loading;
  bool isScrollTop = false;
  RxList<Channel> channels = List<Channel>.empty(growable: true).obs;
}

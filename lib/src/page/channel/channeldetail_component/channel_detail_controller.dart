import 'package:get/get.dart';

import '../../../models/Channel.dart';
import '../../../models/enumn/stories_type.dart';
import '../../../models/request/article/article_request.dart';

class ChannelDetailController extends GetxController {
  var channel = Channel();
  int isFav = 0;
  StoriesType? currentStoriesType;
  ArticleRequest? articleRequest;
  var articles = List.empty(growable: true);
}

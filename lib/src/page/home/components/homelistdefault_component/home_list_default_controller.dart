import 'package:get/get.dart';

import '../../../../models/Item.dart';
import '../../../../models/enumn/stories_type.dart';
import '../../../../models/request/article/article_request.dart';

class HomeListDefaultController extends GetxController {
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 10, pageNum: 1, storiesType: StoriesType.topStories);
  StoriesType currentStoriesType = StoriesType.topStories;
  StoriesType lastStoriesType = StoriesType.topStories;
  LoadingStatus articleLoadingStatus = LoadingStatus.loading;
  bool isScrollTop = false;
  var articles = List.empty(growable: true);
}

import 'package:get/get.dart';

import '../../../../common/repo.dart';
import '../../../../models/Item.dart';
import '../../../../models/enumn/stories_type.dart';
import '../../../../models/request/article/article_request.dart';

class HomeListController extends GetxController {
  var currentStoriesType = StoriesType.topStories.obs;
  var articles = Map<String, ArticleItem>();
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 10, pageNum: 1, storiesType: StoriesType.topStories);

  void updateStories(StoriesType storiesType) {
    currentStoriesType.value = storiesType;
    update();
  }

  Future<Map<String, ArticleItem>> initArticles(StoriesType storiesType) async {
    articleRequest.pageNum = 1;
    articleRequest.offset = null;
    articleRequest.storiesType = storiesType;
    List<ArticleItem> fetchedArticles = await Repo.getArticles(articleRequest);
    if (fetchedArticles.isNotEmpty) {
      articles.clear();
      fetchedArticles.forEach((element) {
        articles.putIfAbsent(element.title, () => element);
      });
    }
    return articles;
  }
}

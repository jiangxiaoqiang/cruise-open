import 'package:get/get.dart';

import '../../../../common/repo.dart';
import '../../../../models/Item.dart';
import '../../../../models/enumn/stories_type.dart';
import '../../../../models/request/article/article_request.dart';

class HomeListDefaultController extends GetxController {
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 10, pageNum: 1, storiesType: StoriesType.topStories);
  StoriesType currentStoriesType = StoriesType.topStories;
  StoriesType lastStoriesType = StoriesType.topStories;
  var articleLoadingStatus = LoadingStatus.loading.obs;
  var isScrollTop = false.obs;
  var articles = Map<String, Item>().obs;

  Future initArticles(StoriesType storiesType) async {
    articleRequest.pageNum = 1;
    articleRequest.offset = null;
    articleRequest.storiesType = storiesType;
    List<Item> fetchedArticles = await Repo.getArticles(articleRequest);
    if (fetchedArticles.isNotEmpty) {
      fetchedArticles.forEach((element) {
        articles.value.putIfAbsent(element.title, () => element);
      });
    }
    articleLoadingStatus.value = LoadingStatus.complete;
    update();
  }

  void appendArticles(List<Item> articlesNew) {
    articlesNew.forEach((element) {
      articles.value.putIfAbsent(element.title, () => element);
    });
    update();
  }

  void updateScroll(bool scrollToTop) {
    isScrollTop.value = scrollToTop;
    update();
  }
}

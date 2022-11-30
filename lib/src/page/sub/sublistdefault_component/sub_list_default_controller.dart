import 'package:get/get.dart';

import '../../../common/repo.dart';
import '../../../models/Item.dart';
import '../../../models/enumn/stories_type.dart';
import '../../../models/request/article/article_request.dart';

class SubListDefaultController extends GetxController {
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 10, pageNum: 1, storiesType: StoriesType.topStories);
  StoriesType currentStoriesType = StoriesType.topStories;
  StoriesType lastStoriesType = StoriesType.topStories;
  var articleLoadingStatus = LoadingStatus.loading.obs;
  List<ArticleItem> articles = List<ArticleItem>.empty(growable: true);
  var isScrollTop = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateScrollUp(bool newScrollTop) {
    isScrollTop.value = newScrollTop;
    update();
  }

  Future initArticles() async {
    if (articles.isNotEmpty) return;
    articleRequest.pageNum = 1;
    articleRequest.offset = null;
    articleRequest.storiesType = StoriesType.subStories;
    List<ArticleItem> fetchedArticles = await Repo.getArticles(articleRequest);
    articles = fetchedArticles;
    articleLoadingStatus.value = LoadingStatus.complete;
    update();
  }

  Future loadingMoreArticles() async {
    articleRequest.pageNum = articleRequest.pageNum + 1;
    List<ArticleItem> extraArticles = await Repo.getArticles(articleRequest);
    if (extraArticles.isNotEmpty) {
      articles.addAll(extraArticles);
      update();
    }
  }

  Future fetchNewestArticles() async {
    articleRequest.offset = null;
    articleRequest.pageSize = 10;
    articleRequest.pageNum = 1;
    List<ArticleItem> newestArticles = await Repo.getArticles(articleRequest);
    if (newestArticles.isNotEmpty) {
      articles.clear();
      articles.addAll(newestArticles);
      update();
    }
  }
}

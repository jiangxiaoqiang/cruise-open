import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/repo.dart';
import '../../../../models/Item.dart';
import '../../../../models/enumn/stories_type.dart';
import '../../../../models/request/article/article_request.dart';

class HomeListDefaultController extends GetxController {
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 10, pageNum: 1, storiesType: StoriesType.topStories);
  StoriesType currentStoriesType = StoriesType.topStories;
  StoriesType lastStoriesType = StoriesType.topStories;
  var articleLoadingStatus = LoadingStatus.loading;
  var isScrollTop = false.obs;
  var articles = Map<String, ArticleItem>();

  Future initArticles(StoriesType storiesType) async {
    if (articles.length == 0) {
      articleRequest.pageNum = 1;
      articleRequest.offset = null;
      articleRequest.storiesType = storiesType;
      List<ArticleItem> fetchedArticles = await Repo.getArticles(articleRequest);
      if (fetchedArticles.isNotEmpty) {
        fetchedArticles.forEach((element) {
          articles.putIfAbsent(element.title, () => element);
        });
        int maxArticleId = fetchedArticles.map((e) => int.parse(e.id)).toList().max;
        if (articleRequest.offset == null) {
          articleRequest.offset = maxArticleId;
        }
      }
      articleLoadingStatus = LoadingStatus.complete;
      update();
    }
  }

  Future<void> loadNewestArticles(RefreshController _refreshController) async {
    var fetchNewestReq = new ArticleRequest(offset: null, pageSize: 10, pageNum: 1, storiesType: currentStoriesType);
    List<ArticleItem> responseArticles = await Repo.getArticles(fetchNewestReq);
    if (responseArticles.isEmpty) {
      _refreshController.refreshCompleted();
      return;
    }
    articles.clear();
    responseArticles.forEach((element) {
      articles.putIfAbsent(element.title, () => element);
    });
    _refreshController.refreshCompleted();
    update();
  }

  void appendArticles(List<ArticleItem> articlesNew) {
    articlesNew.forEach((element) {
      articles.putIfAbsent(element.title, () => element);
    });
    update();
  }

  void updateScroll(bool scrollToTop) {
    isScrollTop.value = scrollToTop;
    update();
  }
}

import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeListDefaultAction {
  action,
  loading_more_articles,
  loading_more_articles_update,
  fetch_articleIds,
  set_articleIds,
}

class HomeListDefaultActionCreator {
  static Action onAction() {
    return const Action(HomeListDefaultAction.action);
  }

  static Action onLoadingMoreArticles(ArticleRequest articleRequest) {
    return Action(HomeListDefaultAction.loading_more_articles,
        payload: articleRequest);
  }

  static Action onLoadingMoreArticlesUpdate(List<Item> articles) {
    return Action(HomeListDefaultAction.loading_more_articles_update,
        payload: articles);
  }

  static Action onGetArticleIds(ArticleRequest articleRequest) {
    return Action(HomeListDefaultAction.fetch_articleIds,payload: articleRequest);
  }

  static Action onSetArticleIds(List<int> articleIds,ArticleRequest articleRequest) {
    ArticlePayload articlePayload = new ArticlePayload();
    articlePayload.articleRequest = articleRequest;
    articlePayload.articleIds = articleIds;
    return Action(HomeListDefaultAction.set_articleIds, payload: articlePayload);
  }
}

class ArticlePayload{
  ArticleRequest articleRequest;
  List<int> articleIds;
}

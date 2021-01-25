import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeListDefaultAction {
  loading_more_articles,
  loading_more_articles_update,
  fetch_articleIds,
  fetch_newest_articles,
  fetch_newest_articles_update,
  set_articleIds,
  update_article_loading_status,
  resume_scroll_top,
  update_latest_story_type,
}

class HomeListDefaultActionCreator {
  static Action onUpdateArticleLoadingStatus(ArticleLoadingStatus loadingStatus) {
    return Action(HomeListDefaultAction.update_article_loading_status, payload: loadingStatus);
  }

  static Action onUpdateLastStroiesType(StoriesType storiesType) {
    return Action(HomeListDefaultAction.update_latest_story_type, payload: storiesType);
  }

  static Action onResumeScrollTop() {
    return Action(HomeListDefaultAction.resume_scroll_top);
  }

  static Action onLoadingMoreArticles(ArticleRequest articleRequest) {
    return Action(HomeListDefaultAction.loading_more_articles, payload: articleRequest);
  }

  static Action onFetchNewestArticles(ArticleRequest articleRequest) {
    return Action(HomeListDefaultAction.fetch_newest_articles, payload: articleRequest);
  }

  static Action onFetchNewestArticlesUpdate(List<Item> articles) {
    return Action(HomeListDefaultAction.fetch_newest_articles_update, payload: articles);
  }

  static Action onLoadingMoreArticlesUpdate(List<Item> articles) {
    return Action(HomeListDefaultAction.loading_more_articles_update, payload: articles);
  }

  static Action onGetArticleIds(ArticleRequest articleRequest) {
    return Action(HomeListDefaultAction.fetch_articleIds, payload: articleRequest);
  }

  static Action onSetArticleIds(List<int> articleIds, ArticleRequest articleRequest) {
    ArticlePayload articlePayload = new ArticlePayload();
    articlePayload.articleRequest = articleRequest;
    articlePayload.articleIds = articleIds;
    return Action(HomeListDefaultAction.set_articleIds, payload: articlePayload);
  }
}

class ArticlePayload {
  ArticleRequest articleRequest;
  List<int> articleIds;
}

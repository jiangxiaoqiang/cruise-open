import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeListDefaultAction {
  action,
  onloading_more_homelist,
  onloading_more_homelist_update,
  fetch_articleIds,
  set_articleIds,
}

class HomeListDefaultActionCreator {
  static Action onAction() {
    return const Action(HomeListDefaultAction.action);
  }

  static Action onLoadingMoreHomeList(ArticleRequest articleRequest) {
    return Action(HomeListDefaultAction.onloading_more_homelist,
        payload: articleRequest);
  }

  static Action onLoadingMoreHomeListUpdate(List<Item> articles) {
    return Action(HomeListDefaultAction.onloading_more_homelist_update,
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

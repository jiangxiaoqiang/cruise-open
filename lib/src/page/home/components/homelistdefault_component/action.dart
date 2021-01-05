import 'package:Cruise/src/component/home_list_default.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeListDefaultAction {
  action,
  onloading_homelist,
  get_articleIds,
  set_articleIds,
}

class HomeListDefaultActionCreator {
  static Action onAction() {
    return const Action(HomeListDefaultAction.action);
  }

  static Action onLoadingHomeList(ArticleRequest articleRequest) {
    return Action(HomeListDefaultAction.onloading_homelist,
        payload: articleRequest);
  }


  static Action onGetArticleIds(ArticleRequest articleRequest) {
    return Action(HomeListDefaultAction.get_articleIds,payload: articleRequest);
  }

  static Action onSetArticleIds(List<int> articleIds) {
    return Action(HomeListDefaultAction.set_articleIds, payload: articleIds);
  }


}

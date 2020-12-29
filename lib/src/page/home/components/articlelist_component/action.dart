import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticleListAction {
  action,
  get_articles,
  set_articles
}

class ArticleListActionCreator {
  static Action onAction() {
    return const Action(ArticleListAction.action);
  }

  static Action onGetArticles(List<int> articleIds) {
    return Action(ArticleListAction.get_articles, payload: articleIds);
  }

  static Action onSetArticles(List<Item> items) {
    return Action(ArticleListAction.set_articles,payload: items);
  }
}


import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticlePgAction { action, set_detail_article }

class ArticlePgActionCreator {
  static Action onAction() {
    return const Action(ArticlePgAction.action);
  }

  static Action onSetDetailArticle(Item article) {
    return Action(ArticlePgAction.set_detail_article, payload: article);
  }
}

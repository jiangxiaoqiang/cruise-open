import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticlePgAction { set_detail_article }

class ArticlePgActionCreator {
  static Action onSetDetailArticle(Item article) {
    return Action(ArticlePgAction.set_detail_article, payload: article);
  }
}

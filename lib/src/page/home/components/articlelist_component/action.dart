import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticleListAction { action, get_articles, set_articles, set_detail_article, remove_articles_by_channel }

class ArticleListActionCreator {
  static Action onAction() {
    return const Action(ArticleListAction.action);
  }

  static Action onSetArticles(List<Item> articles) {
    return Action(ArticleListAction.set_articles, payload: articles);
  }

  static Action onSetDetailArticle(Item article) {
    return Action(ArticleListAction.set_detail_article, payload: article);
  }

  static Action onRemoveArticlesByChannel(String channelId) {
    return Action(ArticleListAction.remove_articles_by_channel, payload: channelId);
  }
}

import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticleDetailAction { action, clear_detail_artcle }

class ArticleDetailActionCreator {
  static Action onAction() {
    return const Action(ArticleDetailAction.action);
  }

  static Action onClearDetailArticle() {
    return Action(ArticleDetailAction.clear_detail_artcle);
  }
}

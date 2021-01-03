import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticleDetailAction { action }

class ArticleDetailActionCreator {
  static Action onAction() {
    return const Action(ArticleDetailAction.action);
  }
}

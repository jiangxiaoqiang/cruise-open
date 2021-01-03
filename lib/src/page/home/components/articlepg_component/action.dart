import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticlePgAction { action }

class ArticlePgActionCreator {
  static Action onAction() {
    return const Action(ArticlePgAction.action);
  }
}

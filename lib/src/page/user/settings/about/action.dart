import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum aboutAction { action }

class aboutActionCreator {
  static Action onAction() {
    return const Action(aboutAction.action);
  }
}

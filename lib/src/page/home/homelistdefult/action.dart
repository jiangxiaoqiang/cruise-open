import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeListDefaultAction { action }

class HomeListDefaultActionCreator {
  static Action onAction() {
    return const Action(HomeListDefaultAction.action);
  }
}

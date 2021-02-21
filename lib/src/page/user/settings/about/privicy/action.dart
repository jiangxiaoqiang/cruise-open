import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PrivicyAction { action }

class PrivicyActionCreator {
  static Action onAction() {
    return const Action(PrivicyAction.action);
  }
}

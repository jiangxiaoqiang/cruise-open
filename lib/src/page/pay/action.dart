import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PayAction { action }

class PayActionCreator {
  static Action onAction() {
    return const Action(PayAction.action);
  }
}

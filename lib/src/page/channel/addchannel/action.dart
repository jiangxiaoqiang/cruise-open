import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AddChannelAction { action }

class AddChannelActionCreator {
  static Action onAction() {
    return const Action(AddChannelAction.action);
  }
}

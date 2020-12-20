import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelAction { action }

class ChannelActionCreator {
  static Action onAction() {
    return const Action(ChannelAction.action);
  }
}

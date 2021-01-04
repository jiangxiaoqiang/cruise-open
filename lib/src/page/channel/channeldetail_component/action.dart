import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelDetailAction { action }

class ChannelDetailActionCreator {
  static Action onAction() {
    return const Action(ChannelDetailAction.action);
  }
}

import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelsAction { action }

class ChannelsActionCreator {
  static Action onAction() {
    return const Action(ChannelsAction.action);
  }
}

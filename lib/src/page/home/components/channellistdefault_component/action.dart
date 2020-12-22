import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelListDefaultAction { action }

class ChannelListDefaultActionCreator {
  static Action onAction() {
    return const Action(ChannelListDefaultAction.action);
  }
}

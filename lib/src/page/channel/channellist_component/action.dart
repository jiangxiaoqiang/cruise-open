import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelListAction { action }

class ChannelListActionCreator {
  static Action onAction() {
    return const Action(ChannelListAction.action);
  }
}

import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelPgAction { action }

class ChannelPgActionCreator {
  static Action onAction() {
    return const Action(ChannelPgAction.action);
  }
}

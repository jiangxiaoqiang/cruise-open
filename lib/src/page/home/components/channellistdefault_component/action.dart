import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelListDefaultAction { action, loading_channels }

class ChannelListDefaultActionCreator {
  static Action onAction() {
    return const Action(ChannelListDefaultAction.action);
  }

  static Action onLoadingChannels() {
    return const Action(ChannelListDefaultAction.loading_channels);
  }
}

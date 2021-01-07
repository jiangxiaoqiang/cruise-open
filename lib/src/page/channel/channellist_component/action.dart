import 'package:Cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelListAction { action, get_channels, set_channels }

class ChannelListActionCreator {
  static Action onAction() {
    return const Action(ChannelListAction.action);
  }

  static Action onGetChannels(List<int> ids) {}

  static Action onSetChannels(List<Channel> channels) {
    return Action(ChannelListAction.set_channels, payload: channels);
  }
}

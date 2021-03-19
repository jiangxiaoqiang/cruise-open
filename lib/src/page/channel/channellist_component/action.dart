import 'package:cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelListAction { action, get_channels, set_channels,set_detail_channel }

class ChannelListActionCreator {
  static Action onAction() {
    return const Action(ChannelListAction.action);
  }

  static Action onSetChannels(List<Channel> channels) {
    return Action(ChannelListAction.set_channels, payload: channels);
  }

  static Action onSetDetailChannel(Channel channel) {
    return Action(ChannelListAction.set_detail_channel, payload: channel);
  }
}

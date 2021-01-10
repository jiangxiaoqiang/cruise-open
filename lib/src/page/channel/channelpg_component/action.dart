import 'package:Cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelPgAction { action, set_channel_detail }

class ChannelPgActionCreator {
  static Action onAction() {
    return const Action(ChannelPgAction.action);
  }

  static Action onSetDetailChannel(Channel channel) {
    return Action(ChannelPgAction.set_channel_detail, payload: channel);
  }
}

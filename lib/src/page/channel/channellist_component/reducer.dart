import 'package:Cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelListState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelListState>>{
      ChannelListAction.action: _onAction,
      ChannelListAction.set_channels: _onSetChannels,
      ChannelListAction.set_detail_channel: _onSetDetailChannel,
    },
  );
}

ChannelListState _onAction(ChannelListState state, Action action) {
  final ChannelListState newState = state.clone();
  return newState;
}

ChannelListState _onSetChannels(ChannelListState state, Action action) {
  final ChannelListState newState = state.clone();
  List<Channel> channels = (action.payload as List<Channel>);
  newState.channels = channels;
  return newState;
}

ChannelListState _onSetDetailChannel(ChannelListState state, Action action) {
  final ChannelListState newState = state.clone();
  Channel channel = (action.payload as Channel);
  newState.channelPgState.channel = channel;
  return newState;
}

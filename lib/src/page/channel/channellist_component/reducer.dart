import 'package:Cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelListState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelListState>>{
      ChannelListAction.action: _onAction,
      ChannelListAction.set_channels: _onSetChannels,
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

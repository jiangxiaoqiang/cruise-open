import 'package:Cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelListDefaultState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelListDefaultState>>{
      ChannelListDefaultAction.loading_channels: _onLoadingChannels,
      ChannelListDefaultAction.loading_more_channels_update: _onLoadingMoreChannelsUpdate,
    },
  );
}

ChannelListDefaultState _onLoadingChannels(ChannelListDefaultState state, Action action) {
  ChannelListDefaultState newState = state.clone();
  List<int> ids = (action.payload as List<int>);
  newState.channelListState.channelIds = ids;
  return newState;
}

ChannelListDefaultState _onLoadingMoreChannelsUpdate(ChannelListDefaultState state, Action action) {
  final ChannelListDefaultState newState = state.clone();
  List<Channel> channels = (action.payload as List<Channel>);
  newState.channelListState.channels.addAll(channels);
  return newState;
}

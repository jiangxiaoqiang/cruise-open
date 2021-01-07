import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelListDefaultState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelListDefaultState>>{
      ChannelListDefaultAction.loading_channels: _onLoadingChannels,
    },
  );
}

ChannelListDefaultState _onLoadingChannels(
    ChannelListDefaultState state, Action action) {
  ChannelListDefaultState newState = state.clone();
  List<int> ids = (action.payload as List<int>);
  newState.channelListState.channelIds = ids;
  return newState;
}

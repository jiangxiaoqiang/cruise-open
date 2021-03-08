import 'dart:math';

import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/page/home/components/homelistdefault_component/action.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelListDefaultState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelListDefaultState>>{
      ChannelListDefaultAction.loading_channels: _onLoadingChannels,
      ChannelListDefaultAction.loading_more_channels_update: _onLoadingMoreChannelsUpdate,
      ChannelListDefaultAction.set_channel_ids: _onSetChannelIds,
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


ChannelListDefaultState _onSetChannelIds(ChannelListDefaultState state, Action action){
  final ChannelListDefaultState newState = state.clone();
  ArticlePayload payload = (action.payload as ArticlePayload);
  newState.channelListState.channelIds = payload.articleIds!;
  newState.articleRequest = payload.articleRequest!;
  if (payload.articleRequest!.pageNum == 1 && payload.articleIds!.isNotEmpty) {
    newState.articleRequest.offset = payload.articleIds!.reduce(max);
  }
  return newState;
}
import 'dart:math';

import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import '../../../models/article/article_payload.dart';
import 'action.dart';
import 'state.dart';

Reducer<ChannelListDefaultState>? buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelListDefaultState>>{
      ChannelListDefaultAction.loading_channels: _onLoadingChannels,
      ChannelListDefaultAction.loading_more_channels_update: _onLoadingMoreChannelsUpdate,
      ChannelListDefaultAction.set_channel_ids: _onSetChannelIds,
      ChannelListDefaultAction.resume_scroll_top: _onResumeScrollTop,
    },
  );
}

ChannelListDefaultState _onResumeScrollTop(ChannelListDefaultState state, Action action) {
  final ChannelListDefaultState newState = state.clone();
  newState.isScrollTop = false;
  return newState;
}

ChannelListDefaultState _onLoadingChannels(ChannelListDefaultState state, Action action) {
  ChannelListDefaultState newState = state.clone();
  return newState;
}

ChannelListDefaultState _onLoadingMoreChannelsUpdate(ChannelListDefaultState state, Action action) {
  final ChannelListDefaultState newState = state.clone();
  List<Channel> channels = (action.payload as List<Channel>);
  newState.channelLoadingStatus = LoadingStatus.complete;
  newState.channelListState.channels.addAll(channels);
  return newState;
}

ChannelListDefaultState _onSetChannelIds(ChannelListDefaultState state, Action action) {
  final ChannelListDefaultState newState = state.clone();
  ArticlePayload payload = (action.payload as ArticlePayload);
  newState.articleRequest = payload.articleRequest!;
  if (payload.articleRequest!.pageNum == 1 && payload.articleIds!.isNotEmpty) {
    newState.articleRequest.offset = payload.articleIds!.reduce(max);
  }
  return newState;
}

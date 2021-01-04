import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelListDefaultState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelListDefaultState>>{
      ChannelListDefaultAction.action: _onAction,
      ChannelListDefaultAction.loading_channels: _onLoadingChannels,
    },
  );
}

ChannelListDefaultState _onAction(
    ChannelListDefaultState state, Action action) {
  final ChannelListDefaultState newState = state.clone();
  return newState;
}

ChannelListDefaultState _onLoadingChannels(
    ChannelListDefaultState state, Action action) {
  final ChannelListDefaultState newState = state.clone();
  ArticleRequest newReq = (action.payload as ArticleRequest);
  newState.articleRequest = newReq;
  return newState;
}

import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelDetailState>? buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelDetailState>>{
      ChannelDetailAction.action: _onAction,
      ChannelDetailAction.set_channel_id: _onSetChannelId,
      ChannelDetailAction.fetch_channel_article_update: _onFetchChannelArticleUpdate,
      ChannelDetailAction.subscribe: _onSubscribe,
    },
  );
}

ChannelDetailState _onAction(ChannelDetailState state, Action action) {
  final ChannelDetailState newState = state.clone();
  return newState;
}

ChannelDetailState _onSetChannelId(ChannelDetailState state, Action action) {
  final ChannelDetailState newState = state.clone();
  String channelId = action.payload as String;
  newState.articleListState.channelId = int.parse(channelId);
  return newState;
}

ChannelDetailState _onFetchChannelArticleUpdate(ChannelDetailState state, Action action) {
  final ChannelDetailState newState = state.clone();
  List<Item> articles = action.payload as List<Item>;
  newState.articleListState.articles = articles;
  return newState;
}

ChannelDetailState _onSubscribe(ChannelDetailState state, Action action) {
  final ChannelDetailState newState = state.clone();
  Channel channel = action.payload as Channel;
  newState.channel = channel;
  return newState;
}

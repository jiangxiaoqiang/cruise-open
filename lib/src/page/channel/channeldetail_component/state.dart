import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/page/channel/channelpg_component/state.dart';
import 'package:Cruise/src/page/home/components/articlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelDetailState implements Cloneable<ChannelDetailState> {
  Channel channel = Channel();
  int? isFav;
  StoriesType? currentStoriesType;
  ArticleListState articleListState = ArticleListState();
  ArticleRequest? articleRequest;

  @override
  ChannelDetailState clone() {
    return ChannelDetailState()
      ..channel = this.channel
      ..currentStoriesType = this.currentStoriesType
      ..articleRequest = articleRequest
      ..articleListState = this.articleListState
      ..isFav = this.isFav;
  }
}

class ChannelDetailConnector extends ConnOp<ChannelPgState, ChannelDetailState> {
  @override
  ChannelDetailState get(ChannelPgState state) {
    ChannelDetailState subState = state.channelDetailState.clone();
    subState.channel = state.channel;
    return subState;
  }

  @override
  void set(ChannelPgState state, ChannelDetailState subState) {
    state.channelDetailState = subState;
  }
}

import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:cruise/src/page/channel/channelpg_component/state.dart';
import 'package:cruise/src/page/home/components/articlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelDetailState implements Cloneable<ChannelDetailState> {
  Channel channel = Channel();
  int isFav = 0;
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
  ChannelDetailState get(ChannelPgState? state) {
    ChannelDetailState subState = state!.channelDetailState.clone();
    subState.channel = state.channel;
    return subState;
  }

  @override
  void set(ChannelPgState state, ChannelDetailState subState) {
    state.channelDetailState = subState;
  }
}

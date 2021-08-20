import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:cruise/src/page/channel/channellist_component/state.dart';
import 'package:cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelListDefaultState implements Cloneable<ChannelListDefaultState> {
  ArticleRequest articleRequest = new ArticleRequest(pageNum: 1, pageSize: 15, storiesType: StoriesType.channels);

  ChannelListState channelListState = ChannelListState();
  LoadingStatus channelLoadingStatus = LoadingStatus.loading;
  bool isScrollTop = false;

  @override
  ChannelListDefaultState clone() {
    return ChannelListDefaultState()
      ..articleRequest = this.articleRequest
      ..channelLoadingStatus = this.channelLoadingStatus
      ..channelListState = this.channelListState
      ..isScrollTop = this.isScrollTop;
  }
}

class ChannelListDefaultConnector extends ConnOp<HomeListState, ChannelListDefaultState> {
  @override
  ChannelListDefaultState get(HomeListState? state) {
    ChannelListDefaultState subState = state!.channelListDefaultState.clone();
    return subState;
  }

  @override
  void set(HomeListState state, ChannelListDefaultState subState) {
    state.channelListDefaultState = subState;
  }
}

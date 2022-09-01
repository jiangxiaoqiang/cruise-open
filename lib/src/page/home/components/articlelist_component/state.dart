import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/page/channel/channeldetail_component/state.dart';
import 'package:cruise/src/page/home/components/homelistdefault_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ArticleListState implements Cloneable<ArticleListState> {
  List<Item> articles = List.empty();
  Item? article;
  int? channelId;
  LoadingStatus loadingStatus = LoadingStatus.loading;

  @override
  ArticleListState clone() {
    return ArticleListState()
      ..articles = this.articles
      ..channelId = channelId
      ..loadingStatus = this.loadingStatus
      ..article = this.article;
  }
}

class ArticleListConnector extends ConnOp<HomeListDefaultState, ArticleListState> {
  @override
  ArticleListState get(HomeListDefaultState? state) {
    ArticleListState articleListState = state!.articleListState.clone();
    return articleListState;
  }

  @override
  void set(HomeListDefaultState state, ArticleListState subState) {
    state.articleListState = subState;
  }
}

class ArticleListChannelDetailConnector extends ConnOp<ChannelDetailState, ArticleListState> {
  @override
  ArticleListState get(ChannelDetailState? state) {
    ArticleListState articleListState = state!.articleListState.clone();
    return articleListState;
  }

  @override
  void set(ChannelDetailState state, ArticleListState subState) {
    state.articleListState = subState;
  }
}

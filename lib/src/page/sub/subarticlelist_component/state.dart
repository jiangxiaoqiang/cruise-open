import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/page/channel/channeldetail_component/state.dart';
import 'package:cruise/src/page/sub/subarticlepg_component/state.dart';
import 'package:cruise/src/page/sub/sublistdefault_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class SubArticleListState implements Cloneable<SubArticleListState> {
  List<Item> articles = List.empty();
  Item? article;
  int? channelId;
  LoadingStatus loadingStatus = LoadingStatus.loading;
  SubArticlePgState subArticlePgState = SubArticlePgState();

  @override
  SubArticleListState clone() {
    return SubArticleListState()
      ..articles = this.articles
      ..channelId = channelId
      ..subArticlePgState = this.subArticlePgState
      ..loadingStatus = this.loadingStatus
      ..article = this.article;
  }
}

class SubArticleListConnector extends ConnOp<SubListDefaultState, SubArticleListState> {
  @override
  SubArticleListState get(SubListDefaultState? state) {
    SubArticleListState articleListState = state!.subArticleListState.clone();
    return articleListState;
  }

  @override
  void set(SubListDefaultState state, SubArticleListState subState) {
    state.subArticleListState = subState;
  }
}

class SubArticleListChannelDetailConnector extends ConnOp<ChannelDetailState, SubArticleListState> {
  @override
  SubArticleListState get(ChannelDetailState? state) {
    SubArticleListState articleListState = state!.subArticleListState.clone();
    return articleListState;
  }

  @override
  void set(ChannelDetailState state, SubArticleListState subState) {
    state.subArticleListState = subState;
  }
}
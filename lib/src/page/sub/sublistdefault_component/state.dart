import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:cruise/src/page/home/components/homelist_component/state.dart';
import 'package:cruise/src/page/sub/subarticlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class SubListDefaultState implements Cloneable<SubListDefaultState> {
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 10, pageNum: 1, storiesType: StoriesType.topStories);
  StoriesType currentStoriesType = StoriesType.topStories;
  StoriesType lastStoriesType = StoriesType.topStories;
  SubArticleListState subArticleListState = SubArticleListState();
  LoadingStatus articleLoadingStatus = LoadingStatus.loading;
  bool isScrollTop = false;

  @override
  SubListDefaultState clone() {
    return SubListDefaultState()
      ..currentStoriesType = this.currentStoriesType
      ..subArticleListState = this.subArticleListState
      ..isScrollTop = this.isScrollTop
      ..lastStoriesType = this.lastStoriesType
      ..articleLoadingStatus = this.articleLoadingStatus
      ..articleRequest = this.articleRequest;
  }
}

class SubHomeListDefaultConnector extends ConnOp<HomeListState, SubListDefaultState> {
  @override
  SubListDefaultState get(HomeListState? state) {
    SubListDefaultState subState = state!.subListDefaultState.clone();
    subState.currentStoriesType = state.currentStoriesType;
    subState.articleRequest.storiesType = state.currentStoriesType;
    return subState;
  }

  @override
  void set(HomeListState state, SubListDefaultState subState) {
    state.subListDefaultState = subState;
  }
}

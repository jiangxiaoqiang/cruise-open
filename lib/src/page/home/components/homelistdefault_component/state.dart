import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:cruise/src/page/home/components/articlelist_component/state.dart';
import 'package:cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeListDefaultState implements Cloneable<HomeListDefaultState> {
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 10, pageNum: 1, storiesType: StoriesType.topStories);
  StoriesType currentStoriesType = StoriesType.topStories;
  StoriesType lastStoriesType = StoriesType.topStories;
  ArticleListState articleListState = ArticleListState();
  LoadingStatus articleLoadingStatus = LoadingStatus.loading;
  bool isScrollTop = false;

  @override
  HomeListDefaultState clone() {
    return HomeListDefaultState()
      ..currentStoriesType = this.currentStoriesType
      ..articleListState = this.articleListState
      ..isScrollTop = this.isScrollTop
      ..lastStoriesType = this.lastStoriesType
      ..articleLoadingStatus = this.articleLoadingStatus
      ..articleRequest = this.articleRequest;
  }
}

class HomeListDefaultConnector extends ConnOp<HomeListState, HomeListDefaultState> {
  @override
  HomeListDefaultState get(HomeListState state) {
    HomeListDefaultState subState = state.homeListDefaultState.clone();
    subState.currentStoriesType = state.currentStoriesType;
    subState.articleRequest.storiesType = state.currentStoriesType;
    return subState;
  }

  @override
  void set(HomeListState state, HomeListDefaultState subState) {
    state.homeListDefaultState = subState;
  }
}

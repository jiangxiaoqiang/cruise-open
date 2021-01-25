import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/page/home/components/articlelist_component/state.dart';
import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeListDefaultState implements Cloneable<HomeListDefaultState> {
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 10, pageNum: 1, storiesType: StoriesType.topStories);
  StoriesType currentStoriesType = StoriesType.topStories;
  StoriesType lastStoriesType = StoriesType.topStories;
  ArticleListState articleListState = ArticleListState();
  ArticleLoadingStatus articleLoadingStatus = ArticleLoadingStatus.complete;
  bool isScrollTop = false;

  @override
  HomeListDefaultState clone() {
    return HomeListDefaultState()
      ..currentStoriesType = this.currentStoriesType
      ..articleListState = this.articleListState
      ..isScrollTop = this.isScrollTop
      ..lastStoriesType = this.lastStoriesType
      ..articleRequest = this.articleRequest;
  }
}

class HomeListDefaultConnector extends ConnOp<HomeListState, HomeListDefaultState> {
  @override
  HomeListDefaultState get(HomeListState state) {
    HomeListDefaultState substate = state.homeListDefaultState.clone();
    substate.currentStoriesType = state.currentStoriesType;
    return substate;
  }

  @override
  void set(HomeListState state, HomeListDefaultState subState) {
    state.homeListDefaultState = subState;
  }
}

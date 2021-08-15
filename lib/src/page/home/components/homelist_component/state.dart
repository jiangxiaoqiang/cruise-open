import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/page/sub/sublistdefault_component/state.dart';
import 'package:cruise/src/page/user/history/state.dart';
import 'package:cruise/src/page/channel/channellistdefault_component/state.dart';
import 'package:cruise/src/page/home/components/homelistdefault_component/state.dart';
import 'package:cruise/src/page/user/discover/state.dart';
import 'package:cruise/src/page/user/fav/state.dart';
import 'package:fish_redux/fish_redux.dart';

import '../../state.dart';

class HomeListState implements Cloneable<HomeListState> {
  StoriesType currentStoriesType = StoriesType.topStories;
  HomeListDefaultState homeListDefaultState = HomeListDefaultState();
  SubListDefaultState subListDefaultState = SubListDefaultState();
  ChannelListDefaultState channelListDefaultState = ChannelListDefaultState();

  @override
  HomeListState clone() {
    return HomeListState()
      ..currentStoriesType = this.currentStoriesType
      ..homeListDefaultState = this.homeListDefaultState
      ..subListDefaultState = this.subListDefaultState
      ..channelListDefaultState = this.channelListDefaultState;
  }
}

class HomeListConnector extends ConnOp<HomeState, HomeListState> {
  @override
  HomeListState get(HomeState? state) {
    HomeListState subState = state!.homeListState.clone();
    return subState;
  }

  @override
  void set(HomeState state, HomeListState subState) {
    state.homeListState = subState;
  }
}

class FavArticleConnector extends ConnOp<FavArticleState, HomeListState> {
  @override
  HomeListState get(FavArticleState? state) {
    HomeListState subState = state!.homeListState.clone();
    subState.currentStoriesType = state.currentStoriesType;
    return subState;
  }

  @override
  void set(FavArticleState state, HomeListState subState) {
    state.homeListState = subState;
  }
}

class HistoryArticleConnector extends ConnOp<HistoryState, HomeListState> {
  @override
  HomeListState get(HistoryState? state) {
    HomeListState subState = state!.homeListState.clone();
    subState.currentStoriesType = state.currentStoriesType;
    return subState;
  }

  @override
  void set(HistoryState state, HomeListState subState) {
    state.homeListState = subState;
  }
}

class DiscoverConnector extends ConnOp<DiscoverState, HomeListState> {
  @override
  HomeListState get(DiscoverState? state) {
    HomeListState subState = state!.homeListState.clone();
    subState.currentStoriesType = state.currentStoriesType;
    return subState;
  }

  @override
  void set(DiscoverState state, HomeListState subState) {
    state.homeListState = subState;
  }
}

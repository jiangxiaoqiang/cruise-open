import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeListDefaultState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeListDefaultState>>{
      HomeListDefaultAction.action: _onAction,
      HomeListDefaultAction.onloading_homelist: _onLoadingHomelist,
      HomeListDefaultAction.set_articleIds: _onSetArticleIds,
    },
  );
}

HomeListDefaultState _onAction(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  return newState;
}

HomeListDefaultState _onLoadingHomelist(
    HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  newState.articleRequest.latestTime = 2;
  newState.articleRequest.storiesType = StoriesType.topStories;
  return newState;
}

HomeListDefaultState _onSetArticleIds(
    HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  List<int> articleIds = (action.payload as List<int>);
  newState.articleIds = articleIds;
  newState.articleListState.articleIds = articleIds;
  newState.currentStoriesType = state.currentStoriesType;
  return newState;
}



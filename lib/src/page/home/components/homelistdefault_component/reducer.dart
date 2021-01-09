import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeListDefaultState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeListDefaultState>>{
      HomeListDefaultAction.action: _onAction,
      HomeListDefaultAction.onloading_more_homelist_update:
          _onLoadingMoreHomelistUpdate,
      HomeListDefaultAction.set_articleIds: _onSetArticleIds,
    },
  );
}

HomeListDefaultState _onAction(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  return newState;
}

HomeListDefaultState _onLoadingMoreHomelistUpdate(
    HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  List<Item> articles = (action.payload as List<Item>);
  newState.articleListState.articles = articles;
  return newState;
}

HomeListDefaultState _onSetArticleIds(
    HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  ArticlePayload payload = (action.payload as ArticlePayload);
  newState.articleListState.articleIds = payload.articleIds;
  newState.articleRequest = payload.articleRequest;
  newState.currentStoriesType = state.currentStoriesType;
  return newState;
}

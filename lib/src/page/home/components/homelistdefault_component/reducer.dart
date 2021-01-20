import 'dart:math';

import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeListDefaultState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeListDefaultState>>{
      HomeListDefaultAction.loading_more_articles_update: _onLoadingMoreArticlesUpdate,
      HomeListDefaultAction.fetch_newest_articles_update: _onFetchNewestArticlesUpdate,
      HomeListDefaultAction.set_articleIds: _onSetArticleIds,
      HomeListDefaultAction.update_article_loading_status: _onUpdateArticleLoadingStatus,
      HomeListDefaultAction.resume_scroll_top: _onResumeScrollTop,
    },
  );
}

HomeListDefaultState _onResumeScrollTop(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  newState.isScrollTop = false;
  return newState;
}

HomeListDefaultState _onUpdateArticleLoadingStatus(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  ArticleLoadingStatus loadingStatus = (action.payload as ArticleLoadingStatus);
  newState.articleLoadingStatus = loadingStatus;
  return newState;
}

HomeListDefaultState _onLoadingMoreArticlesUpdate(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  List<Item> articles = (action.payload as List<Item>);
  newState.articleListState.articles.addAll(articles);
  return newState;
}

HomeListDefaultState _onFetchNewestArticlesUpdate(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  List<Item> articles = (action.payload as List<Item>);
  newState.articleListState.articles = articles;
  return newState;
}

HomeListDefaultState _onSetArticleIds(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  ArticlePayload payload = (action.payload as ArticlePayload);
  newState.articleListState.articleIds = payload.articleIds;
  newState.articleRequest = payload.articleRequest;
  newState.currentStoriesType = state.currentStoriesType;
  if (payload.articleRequest.pageNum == 1 && payload.articleIds.isNotEmpty) {
    newState.articleRequest.offset = payload.articleIds.reduce(max);
  }
  return newState;
}

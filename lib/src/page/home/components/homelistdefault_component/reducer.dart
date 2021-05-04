import 'dart:math';

import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/page/home/components/articlelist_component/state.dart';
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
      HomeListDefaultAction.update_latest_story_type: _onUpdateLastStoriesType,
    },
  );
}

HomeListDefaultState _onUpdateLastStoriesType(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  StoriesType storiesType = action.payload as StoriesType;
  newState.lastStoriesType = storiesType;
  return newState;
}

HomeListDefaultState _onResumeScrollTop(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  newState.isScrollTop = false;
  return newState;
}

HomeListDefaultState _onUpdateArticleLoadingStatus(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  LoadingStatus loadingStatus = (action.payload as LoadingStatus);
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
  ArticleListState articleListState = state.articleListState.clone();
  articleListState.articles = payload.articles!;
  newState.articleRequest = payload.articleRequest!;
  newState.currentStoriesType = state.currentStoriesType;
  newState.articleLoadingStatus = LoadingStatus.complete;
  newState.articleListState = articleListState;
  if (payload.articleRequest!.pageNum == 1 && payload.articleIds!.isNotEmpty) {
    newState.articleRequest.offset = payload.articleIds!.reduce(max);
  }
  return newState;
}

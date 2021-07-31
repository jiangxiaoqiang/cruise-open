import 'dart:math';

import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/page/sub/subarticlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SubListDefaultState>? buildReducer() {
  return asReducer(
    <Object, Reducer<SubListDefaultState>>{
      HomeListDefaultAction.loading_more_articles_update: _onLoadingMoreArticlesUpdate,
      HomeListDefaultAction.fetch_newest_articles_update: _onFetchNewestArticlesUpdate,
      HomeListDefaultAction.set_articleIds: _onSetArticleIds,
      HomeListDefaultAction.update_article_loading_status: _onUpdateArticleLoadingStatus,
      HomeListDefaultAction.resume_scroll_top: _onResumeScrollTop,
      HomeListDefaultAction.update_latest_story_type: _onUpdateLastStoriesType,
    },
  );
}

SubListDefaultState _onUpdateLastStoriesType(SubListDefaultState state, Action action) {
  final SubListDefaultState newState = state.clone();
  StoriesType storiesType = action.payload as StoriesType;
  newState.lastStoriesType = storiesType;
  return newState;
}

SubListDefaultState _onResumeScrollTop(SubListDefaultState state, Action action) {
  final SubListDefaultState newState = state.clone();
  newState.isScrollTop = false;
  return newState;
}

SubListDefaultState _onUpdateArticleLoadingStatus(SubListDefaultState state, Action action) {
  final SubListDefaultState newState = state.clone();
  LoadingStatus loadingStatus = (action.payload as LoadingStatus);
  newState.articleLoadingStatus = loadingStatus;
  return newState;
}

SubListDefaultState _onLoadingMoreArticlesUpdate(SubListDefaultState state, Action action) {
  final SubListDefaultState newState = state.clone();
  List<Item> articles = (action.payload as List<Item>);
  newState.subArticleListState.articles.addAll(articles);
  return newState;
}

SubListDefaultState _onFetchNewestArticlesUpdate(SubListDefaultState state, Action action) {
  final SubListDefaultState newState = state.clone();
  List<Item> articles = (action.payload as List<Item>);
  newState.subArticleListState.articles = articles;
  return newState;
}

SubListDefaultState _onSetArticleIds(SubListDefaultState state, Action action) {
  final SubListDefaultState newState = state.clone();
  ArticlePayload payload = (action.payload as ArticlePayload);
  SubArticleListState articleListState = state.subArticleListState.clone();
  articleListState.articles = payload.articles!;
  articleListState.loadingStatus = LoadingStatus.complete;
  newState.articleRequest = payload.articleRequest!;
  newState.currentStoriesType = state.currentStoriesType;
  newState.articleLoadingStatus = LoadingStatus.complete;
  newState.subArticleListState = articleListState;
  if (payload.articleRequest!.pageNum == 1 && payload.articleIds!.isNotEmpty) {
    newState.articleRequest.offset = payload.articleIds!.reduce(max);
  }
  return newState;
}

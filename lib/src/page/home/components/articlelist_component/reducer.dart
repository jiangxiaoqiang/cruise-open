import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;

import 'action.dart';
import 'state.dart';

Reducer<ArticleListState>? buildReducer() {
  return asReducer(
    <Object, Reducer<ArticleListState>>{
      ArticleListAction.set_articles: _onSetArticles,
      ArticleListAction.set_detail_article: _onSetDetailArticle,
    },
  );
}

ArticleListState _onSetDetailArticle(ArticleListState state, Action action){
  ArticleListState newState = state.clone();
  Item article = (action.payload as Item);
  newState.articlePgState.scrollControllers.putIfAbsent(article.id, () => new ScrollController());
  newState.articlePgState.article = article;
  return newState;
}

ArticleListState _onSetArticles(ArticleListState state, Action action) {
  ArticleListState newState = state.clone();
  List<Item> articles = (action.payload as List<Item>);
  newState.articles = articles;
  return newState;
}

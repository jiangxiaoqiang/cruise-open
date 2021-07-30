import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;

import 'action.dart';
import 'state.dart';

Reducer<SubArticleListState>? buildReducer() {
  return asReducer(
    <Object, Reducer<SubArticleListState>>{
      ArticleListAction.set_articles: _onSetArticles,
      ArticleListAction.set_detail_article: _onSetDetailArticle,
    },
  );
}

SubArticleListState _onSetDetailArticle(SubArticleListState state, Action action){
  SubArticleListState newState = state.clone();
  Item article = (action.payload as Item);
  newState.subArticlePgState.scrollControllers.putIfAbsent(article.id, () => new ScrollController());
  newState.subArticlePgState.article = article;
  return newState;
}

SubArticleListState _onSetArticles(SubArticleListState state, Action action) {
  SubArticleListState newState = state.clone();
  List<Item> articles = (action.payload as List<Item>);
  newState.articles = articles;
  return newState;
}

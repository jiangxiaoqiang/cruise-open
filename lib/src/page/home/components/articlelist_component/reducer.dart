import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ArticleListState> buildReducer() {
  return asReducer(
    <Object, Reducer<ArticleListState>>{
      ArticleListAction.action: _onAction,
      ArticleListAction.set_articles: _onSetArticles,
      ArticleListAction.set_detail_article: _onSetDetailArticle,
    },
  );
}

ArticleListState _onSetDetailArticle(ArticleListState state, Action action){
  ArticleListState newState = state.clone();
  Item article = (action.payload as Item);
  newState.articlePgState.article = article;
  return newState;
}

ArticleListState _onAction(ArticleListState state, Action action) {
  final ArticleListState newState = state.clone();
  return newState;
}

ArticleListState _onSetArticles(ArticleListState state, Action action) {
  ArticleListState newState = state.clone();
  List<Item> articles = (action.payload as List<Item>);
  newState.articles = articles;
  newState.articleRequest.latestTime = 2;
  return newState;
}

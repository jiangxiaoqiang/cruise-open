import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ArticleDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<ArticleDetailState>>{
      ArticleDetailAction.action: _onAction,
      ArticleDetailAction.clear_detail_artcle: _onClearDetailArticle,
      ArticleDetailAction.set_article: _onSetArticle,
    },
  );
}

ArticleDetailState _onAction(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  return newState;
}

ArticleDetailState _onClearDetailArticle(
    ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  newState.article = null;
  return newState;
}

ArticleDetailState _onSetArticle(
    ArticleDetailState state, Action action) {
  Item article = action.payload as Item;
  final ArticleDetailState newState = state.clone();
  newState.article = article;
  return newState;
}

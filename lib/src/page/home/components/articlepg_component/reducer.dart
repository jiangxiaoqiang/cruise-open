import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ArticlePgState> buildReducer() {
  return asReducer(
    <Object, Reducer<ArticlePgState>>{
      ArticlePgAction.action: _onAction,
      ArticlePgAction.set_detail_article: _onSetDetailArticle,
    },
  );
}

ArticlePgState _onAction(ArticlePgState state, Action action) {
  final ArticlePgState newState = state.clone();
  return newState;
}

ArticlePgState _onSetDetailArticle(ArticlePgState state, Action action) {
  final ArticlePgState newState = state.clone();
  Item article = (action.payload as Item);
  newState.articleDetailState.article = article;
  return newState;
}

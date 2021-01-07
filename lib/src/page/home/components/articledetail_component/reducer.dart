import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ArticleDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<ArticleDetailState>>{
      ArticleDetailAction.action: _onAction,
      ArticleDetailAction.clear_detail_artcle: _onClearDetailArticle,
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

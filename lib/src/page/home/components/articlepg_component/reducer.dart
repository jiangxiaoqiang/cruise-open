import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ArticlePgState> buildReducer() {
  return asReducer(
    <Object, Reducer<ArticlePgState>>{
      ArticlePgAction.set_detail_article: _onSetDetailArticle,
    },
  );
}

ArticlePgState _onSetDetailArticle(ArticlePgState state, Action action) {
  final ArticlePgState newState = state.clone();
  Item article = (action.payload as Item);
  newState.articleDetailState.article = article;
  newState.articleDetailState.scrollController = state.scrollControllers[article.id]!;
  return newState;
}

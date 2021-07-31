import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SubArticlePgState>? buildReducer() {
  return asReducer(
    <Object, Reducer<SubArticlePgState>>{
      ArticlePgAction.set_detail_article: _onSetDetailArticle,
    },
  );
}

SubArticlePgState _onSetDetailArticle(SubArticlePgState state, Action action) {
  final SubArticlePgState newState = state.clone();
  Item article = (action.payload as Item);
  newState.subArticleDetailState.article = article;
  newState.subArticleDetailState.scrollController = state.scrollControllers[article.id]!;
  return newState;
}

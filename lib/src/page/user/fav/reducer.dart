import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FavArticleState> buildReducer() {
  return asReducer(
    <Object, Reducer<FavArticleState>>{
      FavArticleAction.action: _onAction,
      FavArticleAction.change_story_type: _onChangeStoryType,
    },
  );
}

FavArticleState _onAction(FavArticleState state, Action action) {
  final FavArticleState newState = state.clone();
  return newState;
}

FavArticleState _onChangeStoryType(FavArticleState state, Action action) {
  final FavArticleState newState = state.clone();

  return newState;
}

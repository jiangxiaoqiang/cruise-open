import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<FavArticleState>? buildEffect() {
  return combineEffects(<Object, Effect<FavArticleState>>{
    FavArticleAction.action: _onAction,
  });
}

void _onAction(Action action, Context<FavArticleState> ctx) {
}

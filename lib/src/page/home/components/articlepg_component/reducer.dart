import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ArticlePgState> buildReducer() {
  return asReducer(
    <Object, Reducer<ArticlePgState>>{
      ArticlePgAction.action: _onAction,
    },
  );
}

ArticlePgState _onAction(ArticlePgState state, Action action) {
  final ArticlePgState newState = state.clone();
  return newState;
}

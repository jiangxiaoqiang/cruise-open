import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeListDefaultState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeListDefaultState>>{
      HomeListDefaultAction.action: _onAction,
    },
  );
}

HomeListDefaultState _onAction(HomeListDefaultState state, Action action) {
  final HomeListDefaultState newState = state.clone();
  return newState;
}

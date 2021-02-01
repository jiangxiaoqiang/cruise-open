import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DiscoverState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscoverState>>{
      DiscoverAction.action: _onAction,
    },
  );
}

DiscoverState _onAction(DiscoverState state, Action action) {
  final DiscoverState newState = state.clone();
  return newState;
}

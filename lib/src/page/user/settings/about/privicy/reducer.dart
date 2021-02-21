import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PrivicyState> buildReducer() {
  return asReducer(
    <Object, Reducer<PrivicyState>>{
      PrivicyAction.action: _onAction,
    },
  );
}

PrivicyState _onAction(PrivicyState state, Action action) {
  final PrivicyState newState = state.clone();
  return newState;
}

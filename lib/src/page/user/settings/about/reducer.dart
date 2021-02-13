import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<aboutState> buildReducer() {
  return asReducer(
    <Object, Reducer<aboutState>>{
      aboutAction.action: _onAction,
    },
  );
}

aboutState _onAction(aboutState state, Action action) {
  final aboutState newState = state.clone();
  return newState;
}

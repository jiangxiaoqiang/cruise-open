import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AppState> buildReducer() {
  return asReducer(
    <Object, Reducer<AppState>>{
      AppAction.action: _onAction,
      AppAction.onChangeDebug: _onChangeDebug,
    },
  );
}

AppState _onAction(AppState state, Action action) {
  final AppState newState = state.clone();
  return newState;
}

AppState _onChangeDebug(AppState state, Action action) {
  final AppState newState = state.clone();
  newState.showDebug = !state.showDebug;
  return newState;
}
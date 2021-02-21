import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VersionState> buildReducer() {
  return asReducer(
    <Object, Reducer<VersionState>>{
      VersionAction.action: _onAction,
    },
  );
}

VersionState _onAction(VersionState state, Action action) {
  final VersionState newState = state.clone();
  return newState;
}

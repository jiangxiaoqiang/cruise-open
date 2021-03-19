import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CruiseSettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<CruiseSettingState>>{
      cruiseSettingAction.action: _onAction,
    },
  );
}

CruiseSettingState _onAction(CruiseSettingState state, Action action) {
  final CruiseSettingState newState = state.clone();
  return newState;
}

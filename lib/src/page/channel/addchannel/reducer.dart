import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AddChannelState> buildReducer() {
  return asReducer(
    <Object, Reducer<AddChannelState>>{
      AddChannelAction.action: _onAction,
    },
  );
}

AddChannelState _onAction(AddChannelState state, Action action) {
  final AddChannelState newState = state.clone();
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelState>>{
      ChannelAction.action: _onAction,
    },
  );
}

ChannelState _onAction(ChannelState state, Action action) {
  final ChannelState newState = state.clone();
  return newState;
}

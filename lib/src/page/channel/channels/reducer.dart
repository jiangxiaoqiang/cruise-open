import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelsState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelsState>>{
      ChannelsAction.action: _onAction,
    },
  );
}

ChannelsState _onAction(ChannelsState state, Action action) {
  final ChannelsState newState = state.clone();
  return newState;
}

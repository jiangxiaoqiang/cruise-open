import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelListDefaultState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelListDefaultState>>{
      ChannelListDefaultAction.action: _onAction,
    },
  );
}

ChannelListDefaultState _onAction(ChannelListDefaultState state, Action action) {
  final ChannelListDefaultState newState = state.clone();
  return newState;
}

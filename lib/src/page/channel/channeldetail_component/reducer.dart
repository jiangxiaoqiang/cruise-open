import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelDetailState>>{
      ChannelDetailAction.action: _onAction,
    },
  );
}

ChannelDetailState _onAction(ChannelDetailState state, Action action) {
  final ChannelDetailState newState = state.clone();
  return newState;
}

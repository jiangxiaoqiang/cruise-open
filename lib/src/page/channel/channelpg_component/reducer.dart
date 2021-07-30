import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelPgState>? buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelPgState>>{
      ChannelPgAction.action: _onAction,
    },
  );
}

ChannelPgState _onAction(ChannelPgState state, Action action) {
  final ChannelPgState newState = state.clone();
  return newState;
}

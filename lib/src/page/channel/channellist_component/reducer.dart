import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChannelListState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChannelListState>>{
      ChannelListAction.action: _onAction,
    },
  );
}

ChannelListState _onAction(ChannelListState state, Action action) {
  final ChannelListState newState = state.clone();
  return newState;
}

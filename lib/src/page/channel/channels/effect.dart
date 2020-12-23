import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ChannelsState> buildEffect() {
  return combineEffects(<Object, Effect<ChannelsState>>{
    ChannelsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ChannelsState> ctx) {
}

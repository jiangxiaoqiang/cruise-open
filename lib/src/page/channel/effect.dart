import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ChannelState> buildEffect() {
  return combineEffects(<Object, Effect<ChannelState>>{
    ChannelAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ChannelState> ctx) {
}

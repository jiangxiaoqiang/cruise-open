import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ChannelListDefaultState> buildEffect() {
  return combineEffects(<Object, Effect<ChannelListDefaultState>>{
    ChannelListDefaultAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ChannelListDefaultState> ctx) {
}

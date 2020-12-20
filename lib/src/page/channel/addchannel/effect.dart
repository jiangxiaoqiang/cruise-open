import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<AddChannelState> buildEffect() {
  return combineEffects(<Object, Effect<AddChannelState>>{
    AddChannelAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AddChannelState> ctx) {
}

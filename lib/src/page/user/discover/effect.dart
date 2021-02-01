import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<DiscoverState> buildEffect() {
  return combineEffects(<Object, Effect<DiscoverState>>{
    DiscoverAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DiscoverState> ctx) {
}

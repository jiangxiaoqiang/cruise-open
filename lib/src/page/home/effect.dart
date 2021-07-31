import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<HomeState>? buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    HomeAction.switchNav: _onSwitchNav
  });
}

void _onSwitchNav(Action action, Context<HomeState> ctx) {
  ctx.dispatch(HomeActionCreator.onSwitchNavSuccess(action.payload));
}
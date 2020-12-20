import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    HomeAction.action: _onAction,
    HomeAction.switchNav: _onSwitchNav
  });
}

void _onAction(Action action, Context<HomeState> ctx) {
}

void _onSwitchNav(Action action, Context<HomeState> ctx) {
  ctx.dispatch(HomeActionCreator.onSwitchNavSuccess(action.payload));
}
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<HomeListDefaultState> buildEffect() {
  return combineEffects(<Object, Effect<HomeListDefaultState>>{
    HomeListDefaultAction.action: _onAction,
  });
}

void _onAction(Action action, Context<HomeListDefaultState> ctx) {
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<aboutState> buildEffect() {
  return combineEffects(<Object, Effect<aboutState>>{
    aboutAction.action: _onAction,
  });
}

void _onAction(Action action, Context<aboutState> ctx) {
}

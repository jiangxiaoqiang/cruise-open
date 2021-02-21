import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<PrivicyState> buildEffect() {
  return combineEffects(<Object, Effect<PrivicyState>>{
    PrivicyAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PrivicyState> ctx) {
}

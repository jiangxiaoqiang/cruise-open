import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<AppState> buildEffect() {
  return combineEffects(<Object, Effect<AppState>>{
    AppAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AppState> ctx) {
}

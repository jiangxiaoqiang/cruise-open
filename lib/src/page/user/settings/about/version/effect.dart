import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<VersionState> buildEffect() {
  return combineEffects(<Object, Effect<VersionState>>{
    VersionAction.action: _onAction,
  });
}

void _onAction(Action action, Context<VersionState> ctx) {
}

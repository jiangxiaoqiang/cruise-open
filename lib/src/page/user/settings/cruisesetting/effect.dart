import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<CruiseSettingState> buildEffect() {
  return combineEffects(<Object, Effect<CruiseSettingState>>{
    CruiseSettingAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CruiseSettingState> ctx) {
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ContractState> buildEffect() {
  return combineEffects(<Object, Effect<ContractState>>{
    ContractAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ContractState> ctx) {
}

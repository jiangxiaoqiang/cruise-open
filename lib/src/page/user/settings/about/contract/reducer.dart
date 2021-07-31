import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ContractState>? buildReducer() {
  return asReducer(
    <Object, Reducer<ContractState>>{
      ContractAction.action: _onAction,
    },
  );
}

ContractState _onAction(ContractState state, Action action) {
  final ContractState newState = state.clone();
  return newState;
}

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PayState> buildReducer() {
  return asReducer(
    <Object, Reducer<PayState>>{
      PayAction.action: _onAction,
    },
  );
}

PayState _onAction(PayState state, Action action) {
  final PayState newState = state.clone();
  return newState;
}

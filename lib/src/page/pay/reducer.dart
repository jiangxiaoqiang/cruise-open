import 'package:cruise/src/models/pay/pay_model.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PayState> buildReducer() {
  return asReducer(
    <Object, Reducer<PayState>>{
      PayAction.action: _onAction,
      PayAction.update:_onUpdate,
    },
  );
}

PayState _onAction(PayState state, Action action) {
  final PayState newState = state.clone();
  return newState;
}

PayState _onUpdate(PayState state, Action action) {
  final PayState newState = state.clone();
  PayModel payModel = action.payload as PayModel;
  newState.payModel = payModel;
  return newState;
}

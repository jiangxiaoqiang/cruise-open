import 'package:cruise/src/models/pay/pay_model.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PayState> buildReducer() {
  return asReducer(
    <Object, Reducer<PayState>>{
      PayAction.set_consumable: _onSetConsumable,
      PayAction.change_pending: _onChangePending,
      PayAction.update:_onUpdate,
      PayAction.verify_purchase: _verifyPurchase
    },
  );
}

PayState _onChangePending(PayState state, Action action) {
  final PayState newState = state.clone();
  bool consumable = action.payload as bool;
  newState.payModel.purchasePending = consumable;
  return newState;
}

PayState _onSetConsumable(PayState state, Action action) {
  final PayState newState = state.clone();
  List<String> consumable = action.payload as List<String>;
  newState.payModel.consumables = consumable;
  return newState;
}

PayState _onUpdate(PayState state, Action action) {
  final PayState newState = state.clone();
  PayModel payModel = action.payload as PayModel;
  newState.payModel = payModel;
  return newState;
}

PayState _verifyPurchase(PayState state, Action action) {
  final PayState newState = state.clone();
  PayModel payModel = action.payload as PayModel;
  newState.payModel = payModel;
  return newState;
}

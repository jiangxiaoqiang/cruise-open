import 'package:Cruise/src/page/home/home_model.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{
      HomeAction.action: _onAction,
      HomeAction.switchNavSuccess: _onSwitchNavSuccess
    },
  );
}

HomeState _onAction(HomeState state, Action action) {
  final HomeState newState = state.clone();
  return newState;
}

HomeState _onSwitchNavSuccess(HomeState state, Action action) {
  if (action.payload == null) {
    return state;
  }
  final HomeState newState = state.clone();
  newState.storiesType = (action.payload as HomeModel).storiesType;
  newState.selectIndex = (action.payload as HomeModel).selectIndex;
  return newState;
}

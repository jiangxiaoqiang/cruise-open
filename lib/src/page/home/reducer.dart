import 'package:cruise/src/models/home_model.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{HomeAction.switchNavSuccess: _onSwitchNavSuccess, HomeAction.scroll_top: _onScrollTop},
  );
}

HomeState _onScrollTop(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState.homeListState.homeListDefaultState.isScrollTop = true;
  return newState;
}

HomeState _onSwitchNavSuccess(HomeState state, Action action) {
  if (action.payload == null) {
    return state;
  }
  final HomeState newState = state.clone();
  newState.storiesType = (action.payload as HomeModel).storiesType!;
  newState.selectIndex = (action.payload as HomeModel).selectIndex!;
  newState.homeListState.currentStoriesType = (action.payload as HomeModel).storiesType!;
  return newState;
}

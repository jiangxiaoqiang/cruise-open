import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/models/home_model.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeState>? buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{HomeAction.switchNavSuccess: _onSwitchNavSuccess, HomeAction.scroll_top: _onScrollTop},
  );
}

HomeState _onScrollTop(HomeState state, Action action) {
  final HomeState newState = state.clone();
  // newState.homeListState.subListDefaultState.isScrollTop = true;
  newState.homeListState.channelListDefaultState.isScrollTop = true;
  return newState;
}

HomeState _onSwitchNavSuccess(HomeState state, Action action) {
  if (action.payload == null) {
    return state;
  }
  StoriesType storiesType = (action.payload as HomeModel).storiesType!;
  final HomeState newState = state.clone();
  newState.storiesType = storiesType;
  newState.selectIndex = (action.payload as HomeModel).selectIndex!;
  newState.homeListState.currentStoriesType = (action.payload as HomeModel).storiesType!;

  return newState;
}

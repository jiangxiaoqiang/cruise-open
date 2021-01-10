import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeListState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeListState>>{
      HomeListAction.action: _onAction,
      HomeListAction.change_stories_type: _onChangeStoriesType,
    },
  );
}

HomeListState _onAction(HomeListState state, Action action) {
  final HomeListState newState = state.clone();
  return newState;
}

HomeListState _onChangeStoriesType(HomeListState state, Action action) {
  final HomeListState newState = state.clone();
  StoriesType storiesType = action.payload as StoriesType;
  newState.currentStoriesType = storiesType;
  return newState;
}

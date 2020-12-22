import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/page/home/components/homelistdefault_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import '../../state.dart';

class HomeListState implements Cloneable<HomeListState> {

  StoriesType currentStoriesType;

  HomeListDefaultState homeListDefaultState;

  @override
  HomeListState clone() {
    return HomeListState()
    ..currentStoriesType = this.currentStoriesType
    ..homeListDefaultState = this.homeListDefaultState;
  }
}

class HomeListConnector extends ConnOp<HomeState, HomeListState> {
  @override
  HomeListState get(HomeState state) {
    HomeListState substate = state.homeListState.clone();
    return substate;
  }
}
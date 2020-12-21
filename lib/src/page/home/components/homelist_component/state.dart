import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import '../../state.dart';

class HomeListState implements Cloneable<HomeListState> {

  StoriesType currentStoriesType;

  @override
  HomeListState clone() {
    return HomeListState();
  }
}

class HomeListConnector extends ConnOp<HomeState, HomeListState> {
  @override
  HomeListState get(HomeState state) {
    HomeListState substate = state.homeListState.clone();
    return substate;
  }
}
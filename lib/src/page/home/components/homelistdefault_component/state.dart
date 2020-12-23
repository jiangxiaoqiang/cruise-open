import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeListDefaultState implements Cloneable<HomeListDefaultState> {
  StoriesType currentStoriesType;

  @override
  HomeListDefaultState clone() {
    return HomeListDefaultState()
    ..currentStoriesType = this.currentStoriesType;
  }
}

class HomeListDefaultConnector
    extends ConnOp<HomeListState, HomeListDefaultState> {
  @override
  HomeListDefaultState get(HomeListState state) {
    HomeListDefaultState substate = state.homeListDefaultState.clone();
    substate.currentStoriesType = state.currentStoriesType;
    return substate;
  }
}

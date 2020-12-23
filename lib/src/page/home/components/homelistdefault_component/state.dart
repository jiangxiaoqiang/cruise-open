import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeListDefaultState implements Cloneable<HomeListDefaultState> {



  @override
  HomeListDefaultState clone() {
    return HomeListDefaultState();
  }
}

class HomeListDefaultConnector extends ConnOp<HomeListState, HomeListDefaultState> {
  @override
  HomeListDefaultState get(HomeListState state) {
    HomeListDefaultState substate = state.homeListDefaultState.clone();
    return substate;
  }
}

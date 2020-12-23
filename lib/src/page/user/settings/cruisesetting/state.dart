import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class CruiseSettingState implements Cloneable<CruiseSettingState> {

  @override
  CruiseSettingState clone() {
    return CruiseSettingState();
  }
}

class CruiseSettingConnector extends ConnOp<HomeListState, CruiseSettingState> {
  @override
  CruiseSettingState get(HomeListState state) {
    CruiseSettingState substate = state.cruiseSettingState.clone();
    return substate;
  }
}

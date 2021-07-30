import 'package:cruise/src/page/home/components/homelist_component/state.dart';
import 'package:cruise/src/page/user/fav/state.dart';
import 'package:fish_redux/fish_redux.dart';

class CruiseSettingState implements Cloneable<CruiseSettingState> {

  FavArticleState? favArticleState;

  @override
  CruiseSettingState clone() {
    return CruiseSettingState();
  }
}

class CruiseSettingConnector extends ConnOp<HomeListState, CruiseSettingState> {
  @override
  CruiseSettingState get(HomeListState? state) {
    CruiseSettingState subState = state!.cruiseSettingState.clone();
    return subState;
  }
}


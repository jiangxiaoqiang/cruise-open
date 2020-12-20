import 'package:fish_redux/fish_redux.dart';

import 'home_model.dart';

//TODO replace with your own action
enum HomeAction { action,switchNav,switchNavSuccess }

class HomeActionCreator {
  static Action onAction() {
    return const Action(HomeAction.action);
  }

  static Action onSwitchNav(HomeModel homeModel){
    return Action(HomeAction.switchNav,payload: homeModel);
  }

  static Action onSwitchNavSuccess(){
    return const Action(HomeAction.switchNavSuccess);
  }
}

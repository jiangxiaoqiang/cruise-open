import 'package:Cruise/src/models/home_model.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeAction { action, switchNav, switchNavSuccess, scroll_top }

class HomeActionCreator {
  static Action onAction() {
    return const Action(HomeAction.action);
  }

  static Action onSwitchNav(HomeModel homeModel) {
    return Action(HomeAction.switchNav, payload: homeModel);
  }

  static Action onSwitchNavSuccess(HomeModel homeModel) {
    return Action(HomeAction.switchNavSuccess, payload: homeModel);
  }

  static Action onScrollTop() {
    return Action(HomeAction.scroll_top);
  }
}

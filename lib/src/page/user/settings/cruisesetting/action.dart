import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum cruiseSettingAction { action }

class cruiseSettingActionCreator {
  static Action onAction() {
    return const Action(cruiseSettingAction.action);
  }
}

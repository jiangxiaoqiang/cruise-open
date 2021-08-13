import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AppAction { action, onChangeDebug }

class AppActionCreator {
  static Action onAction() {
    return const Action(AppAction.action);
  }
  static Action onChangeDebug() {
    return const Action(AppAction.onChangeDebug);
  }
}

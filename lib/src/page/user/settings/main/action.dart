import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MainAction { action , changeDebug}

class MainActionCreator {
  static Action onAction() {
    return const Action(MainAction.action);
  }

  static Action onChangeDebug() {
    return const Action(MainAction.changeDebug);
  }
}

import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { changeThemeColor , changeDebug}

class GlobalActionCreator{
  static Action onChangeThemeColor(){
    return const Action(GlobalAction.changeThemeColor);
  }

  static Action onChangeDebug(){
    return const Action(GlobalAction.changeDebug);
  }
}
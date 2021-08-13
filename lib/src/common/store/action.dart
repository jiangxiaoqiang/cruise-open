import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { changeDebug}

class GlobalActionCreator{
  static Action onChangeDebug(){
    return const Action(GlobalAction.changeDebug);
  }
}
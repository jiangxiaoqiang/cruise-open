

import 'package:cruise/src/common/store/state.dart';
import 'package:fish_redux/fish_redux.dart';

class MainState implements GlobalBaseState,Cloneable<MainState> {

  @override
  MainState clone() {
    return MainState()
    ..showDebug = showDebug;
  }

  @override
  bool showDebug = false;
}

MainState initState(Map<String, dynamic> args) {
  return MainState();
}

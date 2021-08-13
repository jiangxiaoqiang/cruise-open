import 'dart:ui';

import 'package:cruise/src/common/store/state.dart';
import 'package:fish_redux/fish_redux.dart';

class MainState implements GlobalBaseState,Cloneable<MainState> {

  @override
  MainState clone() {
    return MainState()
    ..showDebug = this.showDebug
    ..themeColor = this.themeColor;
  }

  @override
  bool showDebug = false;

  @override
  late Color themeColor;
}

MainState initState(Map<String, dynamic> args) {
  return MainState();
}

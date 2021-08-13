import 'dart:ui';

import 'package:cruise/src/common/store/state.dart';
import 'package:fish_redux/fish_redux.dart';

class AppState implements GlobalBaseState, Cloneable<AppState> {
  @override
  AppState clone() {
    return AppState()..showDebug = this.showDebug;
  }

  @override
  late Color themeColor;

  @override
  bool showDebug = false;
}

AppState initState(Map<String, dynamic> args) {
  return AppState();
}

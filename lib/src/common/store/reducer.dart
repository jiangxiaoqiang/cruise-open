import 'dart:ui';

import 'package:cruise/src/common/store/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeDebug: _onChangeDebug,
    },
  );
}

GlobalState _onChangeDebug(GlobalState state, Action action) {
  final bool showDebug = state.showDebug == true ? false : true;
  GlobalState newState = state.clone();
  newState.showDebug = showDebug;
  return newState;
}

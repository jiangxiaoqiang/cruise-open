import 'package:cruise/src/common/store/action.dart';
import 'package:cruise/src/common/store/store.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<MainState> buildEffect() {
  return combineEffects(<Object, Effect<MainState>>{
    MainAction.action: _onAction,
    MainAction.changeDebug: _onChangeDebug,
  });
}

void _onAction(Action action, Context<MainState> ctx) {
}

void _onChangeDebug(Action action, Context<MainState> ctx) {
  GlobalStore.store.dispatch(GlobalActionCreator.onChangeDebug());
}
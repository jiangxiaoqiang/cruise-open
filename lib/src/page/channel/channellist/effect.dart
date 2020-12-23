import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ChannelListState> buildEffect() {
  return combineEffects(<Object, Effect<ChannelListState>>{
    ChannelListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ChannelListState> ctx) {
}

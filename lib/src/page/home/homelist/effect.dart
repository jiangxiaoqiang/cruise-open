import 'package:Cruise/src/page/channel/addchannel/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fish_redux/src/redux/basic.dart' as fishAction;

import 'action.dart';
import 'state.dart';

Effect<HomeListState> buildEffect() {
  return combineEffects(<Object, Effect<HomeListState>>{
    HomeListAction.action: _onAction,
    HomeListAction.jumpAddChannel: _onJumpAddChannel
  });
}

void _onAction(fishAction.Action action, Context<HomeListState> ctx) {
}

void _onJumpAddChannel(fishAction.Action action, Context<HomeListState> ctx) {
  Navigator.push(ctx.context, MaterialPageRoute(builder: (buildContext) {
    return AddChannelPage().buildPage({'addChannel': ctx.state});
  }));
}

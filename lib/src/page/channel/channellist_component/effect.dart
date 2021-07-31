import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ChannelListState>? buildEffect() {
  return combineEffects(<Object, Effect<ChannelListState>>{
    Lifecycle.initState: _onInit,
  });
}

Future _onInit(Action action, Context<ChannelListState> ctx) async {
  ChannelListState channelListState = ctx.state;
  List<Channel> channels = channelListState.channels;
  if (channels.length > 0) {
    ctx.dispatch(ChannelListActionCreator.onSetChannels(channels));
  }
}

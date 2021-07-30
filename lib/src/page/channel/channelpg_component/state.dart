import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/page/channel/channeldetail_component/state.dart';
import 'package:cruise/src/page/channel/channellist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelPgState implements Cloneable<ChannelPgState> {
  Channel channel = Channel();
  ChannelDetailState channelDetailState = ChannelDetailState();

  @override
  ChannelPgState clone() {
    return ChannelPgState()
      ..channel = this.channel
      ..channelDetailState = this.channelDetailState;
  }
}

class ChannelPgConnector extends ConnOp<ChannelListState, ChannelPgState> {
  @override
  ChannelPgState get(ChannelListState? state) {
    ChannelPgState substate = state!.channelPgState.clone();
    return substate;
  }

  @override
  void set(ChannelListState state, ChannelPgState subState) {
    state.channelPgState = subState;
  }
}

ChannelPgState initState(Map<String, dynamic>? args) {
  Channel channel = args!["channel"];

  return ChannelPgState()
    ..channel = channel
    ..channelDetailState = ChannelDetailState();
}

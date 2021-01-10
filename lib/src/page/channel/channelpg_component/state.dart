import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/page/channel/channeldetail_component/state.dart';
import 'package:Cruise/src/page/channel/channellist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelPgState implements Cloneable<ChannelPgState> {
  Channel channel;
  ChannelDetailState channelDetailState = ChannelDetailState();

  @override
  ChannelPgState clone() {
    return ChannelPgState()
    ..channel = this.channel
    ..channelDetailState = this.channelDetailState;
  }
}

class ChannelPgConnector
    extends ConnOp<ChannelListState, ChannelPgState> {
  @override
  ChannelPgState get(ChannelListState state) {
    ChannelPgState substate = state.channelPgState.clone();
    return substate;
  }

  @override
  void set(ChannelListState state, ChannelPgState subState) {
    state.channelPgState = subState;
  }
}

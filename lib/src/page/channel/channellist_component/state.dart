import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/page/channel/channellistdefault_component/state.dart';
import 'package:Cruise/src/page/channel/channelpg_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelListState implements Cloneable<ChannelListState> {
  Channel channel;
  List<int> channelIds = new List();
  List<Channel> channels = new List();
  ChannelPgState channelPgState = ChannelPgState();

  @override
  ChannelListState clone() {
    return ChannelListState()
      ..channel = this.channel
      ..channelIds = this.channelIds
      ..channels = this.channels
      ..channelPgState = this.channelPgState;
  }
}

class ChannelListConnector
    extends ConnOp<ChannelListDefaultState, ChannelListState> {
  @override
  ChannelListState get(ChannelListDefaultState state) {
    ChannelListState substate = state.channelListState.clone();
    return substate;
  }

  @override
  void set(ChannelListDefaultState state, ChannelListState subState) {
    state.channelListState = subState;
  }
}

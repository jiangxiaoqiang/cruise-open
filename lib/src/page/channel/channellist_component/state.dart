import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/page/channel/channellistdefault_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelListState implements Cloneable<ChannelListState> {
  Channel channel;

  @override
  ChannelListState clone() {
    return ChannelListState();
  }
}

class ChannelListConnector
    extends ConnOp<ChannelListDefaultState, ChannelListState> {
  @override
  ChannelListState get(ChannelListDefaultState state) {
    ChannelListState substate = state.channelListState.clone();
    return substate;
  }
}

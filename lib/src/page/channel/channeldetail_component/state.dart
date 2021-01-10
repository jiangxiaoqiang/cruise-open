import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/page/channel/channelpg_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelDetailState implements Cloneable<ChannelDetailState> {

  Channel channel;
  int isFav;

  @override
  ChannelDetailState clone() {
    return ChannelDetailState();
  }
}

class ChannelDetailConnector
    extends ConnOp<ChannelPgState, ChannelDetailState> {
  @override
  ChannelDetailState get(ChannelPgState state) {
    ChannelDetailState substate = state.channelDetailState.clone();
    return substate;
  }

  @override
  void set(ChannelPgState state, ChannelDetailState subState) {
    state.channelDetailState = subState;
  }
}

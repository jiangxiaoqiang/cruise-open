import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelListDefaultState implements Cloneable<ChannelListDefaultState> {

  @override
  ChannelListDefaultState clone() {
    return ChannelListDefaultState();
  }
}

ChannelListDefaultState initState(Map<String, dynamic> args) {
  return ChannelListDefaultState();
}

class ChannelListDefaultConnector extends ConnOp<HomeListState, ChannelListDefaultState> {
  @override
  ChannelListDefaultState get(HomeListState state) {
    ChannelListDefaultState substate = state.channelListDefaultState.clone();
    return substate;
  }
}

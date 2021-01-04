import 'package:Cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelListState implements Cloneable<ChannelListState> {

  Channel channel;

  @override
  ChannelListState clone() {
    return ChannelListState();
  }
}

ChannelListState initState(Map<String, dynamic> args) {
  return ChannelListState();
}

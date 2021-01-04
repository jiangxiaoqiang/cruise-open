import 'package:Cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelPgState implements Cloneable<ChannelPgState> {

  Channel channel;

  @override
  ChannelPgState clone() {
    return ChannelPgState();
  }
}

ChannelPgState initState(Map<String, dynamic> args) {
  return ChannelPgState();
}

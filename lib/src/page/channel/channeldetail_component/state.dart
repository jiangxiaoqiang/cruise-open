import 'package:Cruise/src/models/Channel.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelDetailState implements Cloneable<ChannelDetailState> {

  Channel channel;

  int isFav;

  @override
  ChannelDetailState clone() {
    return ChannelDetailState();
  }
}

ChannelDetailState initState(Map<String, dynamic> args) {
  return ChannelDetailState();
}

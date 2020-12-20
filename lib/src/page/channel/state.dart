import 'package:fish_redux/fish_redux.dart';

class ChannelState implements Cloneable<ChannelState> {

  @override
  ChannelState clone() {
    return ChannelState();
  }
}

ChannelState initState(Map<String, dynamic> args) {
  return ChannelState();
}

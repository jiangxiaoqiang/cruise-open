import 'package:fish_redux/fish_redux.dart';

class ChannelListState implements Cloneable<ChannelListState> {

  List<int> ids;

  @override
  ChannelListState clone() {
    return ChannelListState();
  }
}

ChannelListState initState(Map<String, dynamic> args) {
  return ChannelListState();
}

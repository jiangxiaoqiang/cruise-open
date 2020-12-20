import 'package:fish_redux/fish_redux.dart';

class AddChannelState implements Cloneable<AddChannelState> {

  @override
  AddChannelState clone() {
    return AddChannelState();
  }
}

AddChannelState initState(Map<String, dynamic> args) {
  return AddChannelState();
}

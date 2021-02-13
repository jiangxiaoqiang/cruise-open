import 'package:fish_redux/fish_redux.dart';

class aboutState implements Cloneable<aboutState> {

  @override
  aboutState clone() {
    return aboutState();
  }
}

aboutState initState(Map<String, dynamic> args) {
  return aboutState();
}

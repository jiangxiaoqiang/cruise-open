import 'package:fish_redux/fish_redux.dart';

class PrivicyState implements Cloneable<PrivicyState> {

  @override
  PrivicyState clone() {
    return PrivicyState();
  }
}

PrivicyState initState(Map<String, dynamic> args) {
  return PrivicyState();
}

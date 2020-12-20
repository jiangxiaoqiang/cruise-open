import 'package:fish_redux/fish_redux.dart';

class HomeListDefaultState implements Cloneable<HomeListDefaultState> {

  @override
  HomeListDefaultState clone() {
    return HomeListDefaultState();
  }
}

HomeListDefaultState initState(Map<String, dynamic> args) {
  return HomeListDefaultState();
}
